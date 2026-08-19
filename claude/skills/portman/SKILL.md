---
name: portman
description: Per-worktree dev-server port leases, reconciled against reality. Use when spinning up a new worktree/clone that runs a dev server (polaris web/websocket/dagster, mycelium's docker stack), when two working copies collide on a port (EADDRINUSE, "port 3000 in use", a killed frontend that won't come back), or to see the whole-laptop port inventory. Claims a non-colliding port block for the current worktree and emits the env vars to launch with.
---

# portman

Per-worktree dev-server port leases. Several worktrees/clones of a project run
at once; every dev server wants the same ports, so concurrent worktrees collide.
`portman` hands each worktree a non-colliding block.

## The model (why it works)

**The filesystem is the lease table. Deletion is the release.**

- A worktree **claims** a slot by writing a `.ports.lock` next to its
  `.ports.toml` manifest. It **frees** the slot by ceasing to exist — delete the
  worktree and the lock goes with it. No central registry, no `release` command,
  nothing an agent must remember to clean up.
- **Correctness comes from a live crawl, not stored state.** Every allocation
  unions three sources so it never collides with reality:
  - `lsof` — what's actually bound right now
  - `docker` — running container host ports (with names)
  - crawl of every `.ports.lock` on the laptop — reservations, running or not
- **Slot 0 = the manifest defaults**, reserved for the primary clone (which
  never claims). Slot _n_ offsets every service by `n * stride`. `claim` picks
  the lowest slot whose entire block is free.

## Commands

```sh
portman claim   # idempotent: reuse this worktree's lock, else allocate + write .ports.lock
portman env     # emit `export VAR=port` lines (claims first if needed)
portman ls      # whole-laptop inventory: every lease + what's actually live
portman show    # this worktree's assignment
```

## The workflow

When setting up a fresh worktree that will run a dev server, claim once and
launch through the exported env — nothing gets written to `.env`, and both the
Next process and the standalone `tsx` websocket process inherit the vars:

```sh
eval "$(portman env)" && pnpm dev        # polaris
eval "$(portman env)" && mycelium up --ui --metrics   # mycelium (docker reads MYCELIUM_*_PORT)
```

In herdr, make the first `npx` tab per worktree run exactly that.

To diagnose a collision or "who has port X", run `portman ls` — leases show
`LIVE`/`idle`, and anything bound without a lease is listed separately.

## Manifest (`.ports.toml`, checked into each repo root)

Declares each service, the env var it reads, and its default port:

```toml
[project]
name = "polaris"

[allocation]
stride = 10      # each slot offsets every service by slot*stride
min_slot = 1     # slot 0 = defaults, reserved for the primary clone
max_slot = 20

[services.web]
env = "PORT"
default = 3000

[services.websocket]
env = "WEBSOCKET_PORT"
default = 3001
url_var = "NEXT_PUBLIC_WEBSOCKET_URL"     # optional: a URL that must track the port
url_template = "ws://localhost:{port}"
```

`.ports.lock` (the resolved assignment, JSON) is gitignored — born at claim,
dead with the directory.

## Gotchas

- **Advisory, not a hard lock.** A same-instant double-claim is `flock`-guarded,
  but the ultimate backstop is a loud `EADDRINUSE` — re-run `portman claim` for
  the next block.
- **A service whose port is hardcoded won't honor its lease.** polaris `dagster`
  bakes `--port 3002` into `services/dagster/package.json`; change it to
  `--port ${DAGSTER_PORT:-3002}` for the lease to take effect. `web`/`websocket`
  and all of mycelium already read env vars.
- **The manifest must list every port-binding service**, or an unlisted one
  comes up on its default and can collide across projects.

## Source & install

Lives in the dotfiles repo: `~/Documents/GitHub/ahk-bindings/portman/`
(`portman` script + README). Install: symlink onto PATH —
`ln -s ~/Documents/GitHub/ahk-bindings/portman/portman ~/.local/bin/portman`.
Crawl roots default to `~/Documents/GitHub`; override with `PORTMAN_ROOTS`
(colon-separated).

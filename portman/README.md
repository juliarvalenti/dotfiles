# portman

Per-worktree dev-server port leases, reconciled against reality.

I keep several worktrees/clones of a project running at once. Every dev server
wants the same ports (polaris `web`/`websocket`/`dagster` on 3000/3001/3002,
mycelium's docker stack on 3000/8000/4318/46357), so concurrent worktrees
collide. `portman` hands each worktree a non-colliding block.

## The model

**The filesystem is the lease table. Deletion is the release.**

- A worktree **claims** a slot by writing a `.ports.lock` next to its
  `.ports.toml` manifest.
- It **frees** the slot by ceasing to exist — delete the worktree and the lock
  goes with it. There is no central registry, no `release` command, nothing an
  agent has to remember to clean up.
- **Correctness comes from a crawl, not stored state.** Every allocation unions
  three live sources so it never collides with reality:
  - `lsof`   — what's actually bound right now
  - `docker` — running container host ports (with names)
  - crawl    — every `.ports.lock` on the laptop = reservations, running or not

A deleted worktree has no lock and no live process, so its ports vanish from the
inventory automatically. A worktree that reserved a slot but isn't running still
holds it (via its lock), so two idle worktrees never get overlapping blocks.

## Slots

Slot 0 = the manifest defaults, reserved for the primary clone (which never
claims). Slot _n_ offsets every service by `n * stride`. `claim` picks the
**lowest slot whose entire block is free** per the crawl, so it stays predictable
(slot 2 ≈ the 3020s for polaris) while respecting what's actually taken.

## Usage

```sh
portman claim     # idempotent: reuse this worktree's lock, else allocate + write
portman env       # emit `export VAR=port` lines (claims first if needed)
portman ls        # whole-laptop inventory: every lease + what's actually live
portman show      # this worktree's assignment
```

Wire it into a worktree's dev command (e.g. the herdr `npx` tab):

```sh
eval "$(portman env)" && pnpm dev
```

Both `next` and the `tsx` websocket process inherit the exported vars, so no
`.env` mutation is needed. mycelium's compose reads the same `MYCELIUM_*_PORT`
vars, so the identical wrapper works there.

## Manifest (`.ports.toml`, checked into each repo root)

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
url_var = "NEXT_PUBLIC_WEBSOCKET_URL"      # optional: a URL that must track the port
url_template = "ws://localhost:{port}"
```

`.ports.lock` is the resolved assignment (JSON), gitignored, born at claim and
dead with the directory.

## Config

- `PORTMAN_ROOTS` — colon-separated dirs to crawl for locks.
  Default: `~/Documents/GitHub`.

## Install

```sh
ln -s ~/Documents/GitHub/ahk-bindings/portman/portman ~/.local/bin/portman
```

## Notes

- Allocation is advisory, not a hard lock. A same-instant double-claim is
  guarded by an `flock`, but the ultimate backstop is a loud `EADDRINUSE` when a
  server boots — re-run `portman claim` for the next block.
- polaris `dagster` is the one service whose port is hardcoded
  (`services/dagster/package.json --port 3002`). Change it to
  `--port ${DAGSTER_PORT:-3002}` for the lease to take effect; `web` and
  `websocket` work today with no code change.

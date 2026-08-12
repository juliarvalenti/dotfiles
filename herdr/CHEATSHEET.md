# herdr cheat sheet

**Prefix = `ctrl+a`** — press it, then keep `ctrl` held for the next key.

## Two rules, that's it

1. **Navigate = direction** (the compass): up/down = spaces, left/right = tabs.
2. **Act = verb + scope**: `n`ew / `r`ename / `w` close · no shift = **tab**, shift = **workspace**.

> Hammerspoon maps `ctrl+i/k/j/l` → arrow keys, so the compass is just `ctrl+a` + `ctrl+IJKL`.

## Navigate — the compass

| Keys | Does |
|------|------|
| `ctrl+a` `ctrl+i` | ⬆ prev **space** |
| `ctrl+a` `ctrl+k` | ⬇ next **space** |
| `ctrl+a` `ctrl+j` | ⬅ prev **tab** |
| `ctrl+a` `ctrl+l` | ➡ next **tab** |
| `ctrl+a` `1`…`9` | jump to tab N |
| `ctrl+a` `w`* | space picker (*bare w, herdr default) |

## Act — verb = letter, shift = workspace

| Action | Tab (no shift) | Workspace (shift) |
|--------|----------------|-------------------|
| **New** | `ctrl+a` `ctrl+n` | `ctrl+a` `ctrl+shift+n` |
| **Rename** | `ctrl+a` `ctrl+r` | `ctrl+a` `ctrl+shift+r` |
| **Close** | `ctrl+a` `ctrl+w` | `ctrl+a` `ctrl+shift+w` |

Mnemonic: **n/r/w** = new/rename/close. **shift** = "the big one" (workspace).

## Panes (splits — herdr defaults, only if you use them)

| Keys | Does |
|------|------|
| `ctrl+a` `v` | split vertical |
| `ctrl+a` `-` | split horizontal |
| `ctrl+a` `h` `j` `k` `l` | focus pane ←↓↑→ (bare letters) |
| `ctrl+a` `z` | zoom pane |
| `ctrl+a` `x` | close pane |

## App / misc (herdr defaults)

| Keys | Does |
|------|------|
| `ctrl+a` `b` | toggle sidebar |
| `ctrl+a` `?` | help |
| `ctrl+a` `s` | settings |
| `ctrl+a` `shift+r`* | reload config (*bare shift+r, herdr default) |
| `ctrl+a` `q` | detach session |

## CLI

| Command | Does |
|---------|------|
| `herdr workspace create --cwd <path> --label <name>` | new space at a dir |
| `herdr workspace list` | list spaces |
| `herdr agent list` / `herdr pane list` | find targets (`w#:p#`) |
| `herdr agent prompt <w#:p#> "<text>" [--wait]` | send a prompt to an agent |
| `herdr agent rename <w#:p#> <name>` | name an agent (then target by name) |
| `herdr server reload-config` | reload config.toml live |

Config: `~/.config/herdr/config.toml` — this repo's copy is the source of truth.

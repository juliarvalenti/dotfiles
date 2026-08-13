# herdr cheat sheet

**Prefix = `ctrl+space`** — press it, then keep `ctrl` held for the next key.

## Two rules, that's it

1. **Navigate = direction** (the compass): up/down = spaces, left/right = tabs.
2. **Act = verb + scope**: `n`ew / `r`ename / `w` close · no shift = **tab**, shift = **workspace**.

> Hammerspoon maps `ctrl+i/k/j/l` → arrow keys, so the compass is just `ctrl+space` + `ctrl+IJKL`.

## Navigate — the compass

| Keys | Does |
|------|------|
| `ctrl+space` `ctrl+i` | ⬆ prev **space** |
| `ctrl+space` `ctrl+k` | ⬇ next **space** |
| `ctrl+space` `ctrl+j` | ⬅ prev **tab** |
| `ctrl+space` `ctrl+l` | ➡ next **tab** |
| `ctrl+space` `1`…`9` | jump to tab N |
| `ctrl+space` `w`* | space picker (*bare w, herdr default) |

## Act — verb = letter, shift = workspace

| Action | Tab (no shift) | Workspace (shift) |
|--------|----------------|-------------------|
| **New** | `ctrl+space` `ctrl+n` | `ctrl+space` `ctrl+shift+n` |
| **Rename** | `ctrl+space` `ctrl+r` | `ctrl+space` `ctrl+shift+r` |
| **Close** | `ctrl+space` `ctrl+w` | `ctrl+space` `ctrl+shift+w` |

Mnemonic: **n/r/w** = new/rename/close. **shift** = "the big one" (workspace).

## Panes (splits — herdr defaults, only if you use them)

| Keys | Does |
|------|------|
| `ctrl+space` `v` | split vertical |
| `ctrl+space` `-` | split horizontal |
| `ctrl+space` `h` `j` `k` `l` | focus pane ←↓↑→ (bare letters) |
| `ctrl+space` `z` | zoom pane |
| `ctrl+space` `x` | close pane |

## App / misc (herdr defaults)

| Keys | Does |
|------|------|
| `ctrl+space` `b` | toggle sidebar |
| `ctrl+space` `?` | help |
| `ctrl+space` `s` | settings |
| `ctrl+space` `shift+r`* | reload config (*bare shift+r, herdr default) |
| `ctrl+space` `q` | detach session |

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

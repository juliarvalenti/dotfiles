# herdr cheat sheet

**Prefix = `ctrl+a`** ⭐ (press it, release, then the command key — tmux-style)

> Hammerspoon maps `ctrl+i/k/j/l` → arrow keys globally, so the "arrow" bindings
> below are really `ctrl+a` then `ctrl+i/k/j/l`. Up/down = spaces, left/right = tabs.

## The compass (custom ⭐)

| Keys | Does |
|------|------|
| `ctrl+a` `ctrl+i` | ⬆ previous **space** |
| `ctrl+a` `ctrl+k` | ⬇ next **space** |
| `ctrl+a` `ctrl+j` | ⬅ previous **tab** |
| `ctrl+a` `ctrl+l` | ➡ next **tab** |

## Spaces (long-lived project homes)

| Keys | Does |
|------|------|
| `ctrl+a` `shift+n` | new space |
| `ctrl+a` `shift+w` | rename space |
| `ctrl+a` `shift+d` | close space (confirms) |
| `ctrl+a` `w` | space picker |

## Tabs (short-lived scratch sessions)

| Keys | Does |
|------|------|
| `ctrl+a` `c` | new tab |
| `ctrl+a` `shift+t` | rename tab |
| `ctrl+a` `ctrl+w` | close tab ⭐ (safe reflex — never nukes a space) |
| `ctrl+a` `1`…`9` | jump to tab N |

## Panes (splits — only if you use them)

| Keys | Does |
|------|------|
| `ctrl+a` `v` | split vertical (pane beside) |
| `ctrl+a` `-` | split horizontal (pane below) |
| `ctrl+a` `h` `j` `k` `l` | focus pane ←↓↑→ (bare letters, NOT the arrows) |
| `ctrl+a` `z` | zoom / maximize pane |
| `ctrl+a` `x` | close pane |
| `ctrl+a` `shift+p` | rename pane |

> ⚠️ Caveat: pane focus is on the bare letters `h/j/k/l`. `ctrl+a ctrl+j/ctrl+l`
> (the arrows) switch **tabs**, not panes. Panes = letters, tabs = arrows.

## App / misc

| Keys | Does |
|------|------|
| `ctrl+a` `b` | toggle sidebar |
| `ctrl+a` `g` | goto / navigate mode |
| `ctrl+a` `?` | help |
| `ctrl+a` `s` | settings |
| `ctrl+a` `shift+r` | reload config |
| `ctrl+a` `q` | detach session |

## Handy CLI

| Command | Does |
|---------|------|
| `herdr workspace create --cwd <path> --label <name>` | new space at a dir |
| `herdr workspace list` | list spaces |
| `herdr tab rename <id> <name>` | rename tab (`herdr tab list` for id) |
| `herdr agent list` / `herdr agent rename <id> <name>` | inspect / rename agents |
| `herdr server reload-config` | reload config.toml live |

Config lives at `~/.config/herdr/config.toml` (this repo's copy is the source of truth).
Agents resume into their conversations after a restart (`resume_agents_on_restore`).

# Cyberwave for tmux

The Cyberwave file is deliberately a palette drop-in: it does not redefine
any status-bar content.

Copy `cyberwave.conf` to `~/.config/tmux/themes/`, then add this guarded
include immediately after the existing `color_*` assignments in
`~/.config/tmux/tmux.conf`:

```tmux
if-shell '[ -r ~/.config/tmux/themes/cyberwave.conf ]' \\
  'source-file ~/.config/tmux/themes/cyberwave.conf'
```

If the theme file is absent, the condition is false and tmux continues without
printing an error. Keep the existing `status-format`, `status-left`,
`status-right`, and widget definitions unchanged, then reload:

```sh
tmux source-file ~/.config/tmux/tmux.conf
```

The palette uses the same 256-color values as the existing configuration; the
`screen-256color` terminal setting remains unchanged.

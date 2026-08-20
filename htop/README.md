# Cyberwave for htop

htop 3.3's native configuration only supports choosing one of its built-in
color palettes; it cannot define custom RGB colors. `cyberwave.htoprc` selects
the closest dark built-in palette (`Black Night`) without changing your
layout or process view.

To try it without replacing your settings:

```sh
HTOPRC="$PWD/htop/cyberwave.htoprc" htop
```

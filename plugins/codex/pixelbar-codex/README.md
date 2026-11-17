# Pixelbar for Codex

`pixelbar-codex` is an on-demand status panel for Codex, inspired by
[Zeckon's pixelbar](https://github.com/zeckon/claude-plugins/tree/main/plugins/pixelbar)
for Claude Code.

Codex does not currently expose an extension point for replacing or drawing in
its native status line, so this plugin deliberately does **not** claim to be a
persistent animated bar. Instead, its `pixelbar-status` skill provides the
same useful project-side signals when asked: working directory, Git branch and
working-tree state, ahead/behind counts, diff totals, stash count, and the
latest commit. All commands are read-only.

## Use

Ask Codex to “show the Codex Pixelbar status panel” (or invoke the
`pixelbar-status` skill). You can also run the standalone script from a clone:

```sh
plugins/codex/pixelbar-codex/scripts/pixelbar-codex
```

## Install from this repository

The repo marketplace is at `.agents/plugins/marketplace.json`. Add the repo as
a local marketplace, then install `pixelbar-codex@remkit` in Codex. Start a new
conversation after installation so Codex loads the bundled skill.

## Limitations

- It cannot access Codex model, context-window, usage, cost, or current-turn
  state.
- It cannot add a persistent row, animation, custom keyboard shortcut, or
  color raster to the Codex UI.
- Outside a Git repository, it reports only the current directory and time.

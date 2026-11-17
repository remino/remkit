---
name: pixelbar-status
description: Show a compact, read-only project and Git status panel inspired by the Claude Code pixelbar. Use when the user asks for project status, Git status, a status panel, or Codex Pixelbar.
---

Render a compact status panel for the current project. This skill is strictly
read-only: do not modify the repository, stage files, fetch, or write any
configuration.

Run these commands as applicable:

```sh
git rev-parse --show-toplevel
git branch --show-current
git status --porcelain=v1 --branch
git diff --numstat
git stash list
git log -1 --format='%h %s (%cr)'
```

Report the result in one fenced `text` block, using this shape where values are
available:

```text
▛▜  ▐ CODEX ON-DEMAND ▌ ▐ DIR <folder> ▌ ▐ GIT <branch> *<changed> ^<ahead> v<behind> ▌ ▐ DIFF +<added> -<removed> ▌ ▐ STASH <count> ▌
▟▙  ▐ LAST <short-hash> <subject> (<relative-time>) ▌
```

Omit unavailable or zero-value sections rather than inventing a value. Outside
a Git repository, show the folder and identify it as `NO GIT REPOSITORY`.
Never claim access to Codex's context, cost, model, usage, or turn state: the
Codex plugin API does not make those available to this skill.

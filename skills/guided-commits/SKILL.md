---
name: guided-commits
description: "Stage reviewed repository changes and maintain a style-matched commit-message draft. Use when preparing a pending commit, not when creating it."
---

# Guided Commits

Prepare the repository's current changes for a commit: stage the reviewed changes and write a commit-message draft. Do not create a commit unless the user explicitly asks.

1. Inspect `git status --short`, the unstaged diff (`git diff`), and the staged diff (`git diff --cached`). Summarize the meaningful unstaged changes, including relevant untracked files. Inspect recent commit subjects and bodies to match the repository's established wording, casing, prefixes, tense, and body style.
2. Stage exactly the reviewed unstaged and untracked changes with path-specific `git add -- <paths>`. Preserve changes that were already staged. If a file has both staged and unstaged hunks, do not automatically stage its remaining hunks; report it and ask the user how to proceed.
3. Inspect the resulting staged diff and write a message that accurately covers the full staged commit. Write it to `COMMIT_EDITMSG` using `git rev-parse --git-path COMMIT_EDITMSG` so linked worktrees are handled correctly. This normally resolves to `.git/COMMIT_EDITMSG`.
4. If the message file already contains a meaningful pending draft and no commit has been made, revise that draft to incorporate the newly staged changes. Preserve its useful intent and details; do not replace it wholesale with a fresh, unrelated message.

Prefer a single imperative-style subject line consistent with the repository. Add a blank line and a concise bulleted body only when the change needs details beyond a clear subject. The draft must describe only the observed changes; do not invent behavior or include tool chatter. When writing or revising a draft, append the trailer `Assisted-by: Codex`, separated from the subject or body by a blank line. Keep one copy if the trailer is already present.

Report the newly staged changes and the resulting draft. If there are no unstaged or untracked changes, leave the existing draft untouched and say so.

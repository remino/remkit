---
name: guided-commits
description: "Summarize unstaged repository changes and maintain a style-matched commit-message draft. Use when preparing or updating a pending commit message, not when creating a commit."
---

# Guided Commits

Prepare a commit-message draft for the repository's current unstaged code changes. Do not create a commit unless the user explicitly asks.

1. Inspect the unstaged diff (`git diff`) and summarize the meaningful changes. Also inspect recent commit subjects and bodies to match the repository's established wording, casing, prefixes, tense, and body style.
2. Write the draft to the repository's `COMMIT_EDITMSG` using `git rev-parse --git-path COMMIT_EDITMSG` so linked worktrees are handled correctly. This normally resolves to `.git/COMMIT_EDITMSG`.
3. If the message file already contains a meaningful pending draft and no commit has been made, revise that draft to incorporate the newer unstaged changes. Preserve its useful intent and details; do not replace it wholesale with a fresh, unrelated message.

Prefer a single imperative-style subject line consistent with the repository. Add a blank line and a concise bulleted body only when the change needs details beyond a clear subject. The draft must describe only the observed changes; do not invent behavior or include tool chatter. When writing or revising a draft, append the trailer `Assisted-by: Codex`, separated from the subject or body by a blank line. Keep one copy if the trailer is already present.

Report the unstaged-change summary and the resulting draft. If there are no unstaged changes, leave the existing draft untouched and say so.

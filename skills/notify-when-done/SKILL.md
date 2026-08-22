---
name: notify-when-done
description: Manage and send opt-in IFTTT completion notifications with iftttnotify. Use when the user asks to enable, disable, check, or receive a completion alert.
---

# Notify When Done

Completion notifications are off by default. Their persistent, per-machine
state is the marker file:

```sh
${XDG_CONFIG_HOME:-$HOME/.config}/agent-skills/notify-when-done.enabled
```

Use `scripts/notify-when-done status` before sending. If notifications are
disabled, finish normally without sending an alert or mentioning notification
status in the final response.

When the user explicitly asks to enable, disable, or check completion
notifications, run the corresponding helper command. These changes persist for
all agents that use this skill on the same machine.

Only after the requested work is genuinely complete and any relevant
verification has run or been reported as unavailable, send an enabled
notification with:

```sh
scripts/notify-when-done send '<short title>' '<brief result>' '<path or context>'
```

Keep the values short and useful:

- `value1`: task name or completion summary.
- `value2`: verification outcome, such as `tests passed` or `blocked: missing credentials`.
- `value3`: working directory, pull request URL, deployment URL, or other useful context.

If sending fails because of sandboxing or a network restriction, retry once
with the smallest necessary approval request. Mention success or failure
briefly in the final response only when an alert was attempted.

## Filesystem control

Enable notifications directly:

```sh
touch "${XDG_CONFIG_HOME:-$HOME/.config}/agent-skills/notify-when-done.enabled"
```

Disable notifications directly:

```sh
rm -f "${XDG_CONFIG_HOME:-$HOME/.config}/agent-skills/notify-when-done.enabled"
```

## Requirements

`iftttnotify` is available from [remino/remutils](https://github.com/remino/remutils)
or through Homebrew:

```sh
brew install remino/remino/iftttnotify
```

It reads the IFTTT Webhooks key from `IFTTT_WEBHOOKS_KEY` or
`~/.ifttt-webhooks-key`; never expose the key in commands, logs, or responses.

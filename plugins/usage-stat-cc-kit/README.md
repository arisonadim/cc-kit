# Claude Usage Statusline (usage-stat-cc-kit)

A tiny Claude Code status line plugin that shows how much of your 5-hour session is left.

It is built to stay **lightweight**:
- no extra requests,
- no polling loop,
- no external service,
- no background daemon,
- no Node/Python runtime requirement,
- no log parsing.

It uses the native Claude Code status line flow: Claude Code already computes session data and passes it to the plugin through stdin, and the script only formats that data for display.

## Why this plugin

There are many similar packages, but most add extra layers: wrappers, extra binaries, dashboards, polling, or custom transports.

This plugin keeps the model simple:
- Claude Code calls the script,
- the script reads JSON from stdin,
- the script prints one short line,
- Claude Code renders it.

That makes it reliable, easy to audit, and easy to maintain.

## What it shows

Example output:

```text
5h left: 96.0% | resets in 4h 11m
```

The data comes from Claude Code's native status line payload, including fields such as the 5-hour rate limit usage and reset time.

## Features

- Zero extra network requests beyond Claude Code itself.
- Zero background processes.
- Zero runtime dependencies beyond a POSIX shell and `jq`.
- Native Claude Code marketplace installation flow.
- Fast enough to run every status line refresh without adding noticeable overhead.

## Install

### Install from marketplace

Add the marketplace:

```text
/plugin marketplace add arisonadim/cc-kit
```

Install the plugin:

```text
/plugin install usage-stat-cc-kit@cc-kit
```

Claude Code supports plugin discovery and installation through marketplace repositories that contain `.claude-plugin/marketplace.json`.

### Activate the status line

After installing, add the status line manually to your `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/plugins/cache/cc-kit/usage-stat-cc-kit/unknown/bin/statusline.sh",
    "padding": 1
  }
}
```

Then start a new Claude Code session — the status line is only read at session start.

**Note:** There is no way to do this automatically via `.claude-plugin/plugin.json` — the status line must be added manually to `~/.claude/settings.json`.

**Note:** this plugin intentionally omits `version` from `.claude-plugin/plugin.json`. Claude Code then caches the install under a fixed `unknown/` folder instead of a version number, so the path above stays valid across `/plugin update` runs. (The `version` field in `.claude-plugin/marketplace.json` still tracks the plugin's release version independently.)

## How it works

1. Claude Code updates the status line.
2. Claude Code launches the configured command.
3. Claude Code sends a JSON payload to stdin.
4. The script formats the payload into one readable line.
5. Claude Code displays the returned text.

Status line commands are called by Claude Code itself; the script does not need to call Claude Code back.

## Design goals

- **Simple** — one shell script, one settings file.
- **Reliable** — no scraping, no hidden APIs, no OAuth tricks.
- **Native** — uses documented Claude Code plugin and status line mechanisms.
- **Low overhead** — formatting only, not monitoring.
- **Portable** — easy to inspect and fork.

## Notes

- This plugin is intentionally small.
- It does not add dashboards, analytics, history views, or external collectors.
- If you want historical analysis, use a separate tool. This plugin is for quick in-session visibility only.

## License

MIT

# cc-kit

A repo with plugins for [Claude Code](https://docs.claude.com/en/docs/claude-code) marketplace.

## Install

Add the marketplace, then install any plugin from it:

```text
/plugin marketplace add arisonadim/cc-kit
/plugin install usage-stat-cc-kit@cc-kit
```

## Plugins

| Plugin | Description |
| --- | --- |
| [usage-stat-cc-kit](plugins/usage-stat-cc-kit) | Status line that shows how much of your 5-hour session is left. |

## Structure

```text
cc-kit/
├── .claude-plugin/
│   └── marketplace.json   # marketplace manifest
└── plugins/
    └── usage-stat-cc-kit/  # individual plugin
```

Each plugin lives in its own directory under `plugins/` with its own `.claude-plugin/plugin.json` manifest and README.

## License

MIT

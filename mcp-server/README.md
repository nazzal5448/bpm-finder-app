# BPM Finder - Model Context Protocol (MCP) Server

Model Context Protocol (MCP) server for AI assistants (Cursor, Claude, Copilot Workspaces, Smithery AI) to compute audio tempo, Tap BPM intervals, delay note divisions, and reverb pre-delay values.

Powered by the [BPM Finder App](https://bpmfinderapp.com).

---

## Capabilities & Tools

- `calculate_bpm_tap`: Compute exact BPM from tap timestamp arrays in milliseconds.
- `calculate_delay_times`: Calculate quarter, 8th, 16th, dotted, and triplet delay times in milliseconds for any BPM.
- `calculate_reverb_predelay`: Get tight, natural, and spacious reverb pre-delay settings for any BPM.

---

## Installation & Usage

Add to your MCP settings file (e.g. `claude_desktop_config.json` or Cursor MCP settings):

```json
{
  "mcpServers": {
    "bpm-finder": {
      "command": "npx",
      "args": ["-y", "bpm-finder-app-mcp"]
    }
  }
}
```

---

## Official Web Application

Access full audio file beat detection and online tap tools at the [BPM Finder App](https://bpmfinderapp.com).

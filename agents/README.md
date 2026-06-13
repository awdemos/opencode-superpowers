# Agents Directory

OpenCode does not currently use Kimi-style agent configuration files (`agent.yaml`, `coder.yaml`, etc.). The original `kimi-with-superpowers` project included these files for Kimi Code CLI.

This directory is intentionally left empty in the OpenCode fork. Agent behavior should be controlled via:

1. **Project-level `AGENTS.md`** — place a copy of `prompts/AGENTS.md.template` in your project root.
2. **OpenCode's native `skill` tool** — invoke Superpowers skills as needed.

If OpenCode adds support for custom agent definitions in the future, this directory can be populated with equivalent configurations.

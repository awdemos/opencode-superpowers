# Agents Directory

OpenCode does not currently use Kimi-style agent configuration files (`agent.yaml`, `coder.yaml`, etc.). The original `kimi-with-superpowers` project included those files for the Kimi Code CLI.

This directory is intentionally left empty in the OpenCode fork. Agent behavior should be controlled via:

1. **Project-level `AGENTS.md`** — place a copy of `prompts/AGENTS.md.template` in your project root and replace `PROJECT_NAME`.
2. **OpenCode's native `skill` tool** — invoke Superpowers skills as needed.

`README.md` and `SKILL.md` no longer list non-existent files under `agents/`. If OpenCode adds support for custom agent definitions in the future, this directory can be populated with equivalent configurations.

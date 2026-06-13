# OpenCode Superpowers

Install and configure the [Superpowers](https://github.com/awdemos/opencode-superpowers) workflow for [OpenCode](https://github.com/opencode-ai/opencode/).

Superpowers is a workflow system for AI coding assistants that enforces best practices like:

- Test-Driven Development (TDD)
- Systematic debugging
- Structured planning
- Subagent-driven development

## Quick Start (recommended)

Add the upstream Superpowers plugin to your `opencode.json`:

```json
{
  "plugin": ["superpowers@git+https://github.com/obra/superpowers.git"]
}
```

Restart OpenCode. The plugin registers all Superpowers skills automatically.

If you also want the project-level workflow templates (`AGENTS.md` reminder, Universal Workflow, `PROJECT_CONFIG.yaml`), see the rest of this README.

## What's in this repository

| Path | Purpose |
|------|---------|
| `SKILL.md` | **Start here.** Full installation skill for OpenCode, including migration steps from the old symlink install. |
| `prompts/AGENTS.md.template` | Project-level `AGENTS.md` template. Copy to your project root and customize. |
| `prompts/superpowers-reminder.md` | Inline reminder variant for clients that support system reminders. |
| `workflow/UNIVERSAL_WORKFLOW.md` | Complete 7-stage feature / 4-phase debug workflow. |
| `workflow/CONFIGURATION.md` | Guide for adapting the workflow to your stack. |
| `templates/PROJECT_CONFIG.yaml` | **Copy this** (not `CONFIGURATION.md`) to your project root as `PROJECT_CONFIG.yaml`. |
| `scripts/validate-links.sh` | Repository health check: internal markdown links. |
| `skills/` | Vendored Superpowers skills (used when this repository is cloned as the install source). |

## Compatibility

- **OpenCode**: Any modern version with the `skill` tool and plugin support.
- **Windows / macOS / Linux**: Works on all platforms OpenCode supports.

## License

MIT (same as Superpowers)

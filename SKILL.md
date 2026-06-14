---
name: install-superpowers-for-opencode
description: Use when installing, migrating, or configuring the Superpowers workflow for OpenCode, or when project-level workflow templates are needed alongside the plugin.
---

# Install Superpowers for OpenCode

This skill installs the [Superpowers](https://github.com/obra/superpowers) workflow system for [OpenCode](https://opencode.ai). Superpowers enforces best practices such as TDD, systematic debugging, structured planning, and subagent-driven development.

## Install

Add the upstream plugin to `opencode.json` (global or project-level):

```json
{
  "plugin": ["superpowers@git+https://github.com/obra/superpowers.git"]
}
```

Restart OpenCode. The plugin registers all Superpowers skills automatically.

Verify by asking: **"Tell me about your superpowers."**

For full plugin documentation, see the [upstream OpenCode guide](https://github.com/obra/superpowers/blob/main/docs/README.opencode.md).

## Optional: Project-Level Templates

To add the Universal Workflow, a project config, and a per-project reminder in addition to the plugin:

1. Copy workflow files into your project:

   ```bash
   cp /path/to/opencode-superpowers/workflow/UNIVERSAL_WORKFLOW.md your-project/workflow/
   cp /path/to/opencode-superpowers/workflow/CONFIGURATION.md your-project/workflow/
   ```

2. Copy the config template and set your stack:

   ```bash
   cp /path/to/opencode-superpowers/templates/PROJECT_CONFIG.yaml your-project/PROJECT_CONFIG.yaml
   ```

3. Copy the reminder into your project root:

   ```bash
   cp /path/to/opencode-superpowers/prompts/AGENTS.md.template your-project/AGENTS.md
   ```

   Then replace `PROJECT_NAME` with your project name.

## Uninstall

Remove the plugin line from `opencode.json` and restart OpenCode. Also remove any project-level `AGENTS.md` files you added.

## For AI Assistants

When this skill is invoked, install via the plugin. After installation, guide the user to invoke Superpowers skills via OpenCode's `skill` tool, copy `templates/PROJECT_CONFIG.yaml` and `prompts/AGENTS.md.template` if they want project-level enforcement, and read `workflow/UNIVERSAL_WORKFLOW.md` for the workflow stages.

---

*Skill Version: 3.0 | OpenCode plugin-first, compressed*

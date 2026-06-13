# OpenCode Superpowers

Install and configure [Superpowers](https://github.com/awdemos/opencode-superpowers) workflow for [OpenCode](https://github.com/opencode-ai/opencode/).

## What is this?

Superpowers is a workflow system for AI coding assistants that enforces best practices like:

- Test-Driven Development (TDD)
- Systematic debugging
- Structured planning
- Subagent-driven development

This repository provides installation instructions (as an OpenCode skill) to set up Superpowers for OpenCode.

## How it works

OpenCode already has a native `skill` tool, so skill invocation is simpler than in Kimi. This setup:

1. Places Superpowers skills in OpenCode's skill discovery path (`~/.config/opencode/skills/`).
2. Patches the `using-superpowers` skill to explain OpenCode-native invocation.
3. Provides a project-level `AGENTS.md` template that reminds the agent to load the Universal Workflow and invoke Superpowers skills at the start of each conversation.

## Requirements

- OpenCode installed and available on your system.
- (Optional) A project where you want to enable Superpowers.

## Quick Start

### Option 1: Let AI install it for you

If you're using OpenCode, simply invoke this skill and let the AI handle the installation:

```
Read and follow the instructions from:
https://raw.githubusercontent.com/YOUR_USERNAME/opencode-superpowers/main/SKILL.md
```

### Option 2: Manual installation

1. Ensure OpenCode is installed.
2. Read `SKILL.md` in this repository.
3. Follow the step-by-step instructions for your platform.
4. Copy `prompts/AGENTS.md.template` into any project where you want Superpowers enforced.

## Installation Overview

1. **Clone** this repository to `~/.config/opencode/superpowers/`
2. **Link** skills from `~/.config/opencode/superpowers/skills/` to `~/.config/opencode/skills/`
3. **Patch** the `using-superpowers` skill for OpenCode compatibility
4. **Copy** `prompts/AGENTS.md.template` into your project root (optional)
5. **Install** the Universal Workflow documents into your project (optional)

## Repository Structure

```
.
├── SKILL.md              # Main installation skill (read this!)
├── README.md             # This file
├── agents/               # Pre-configured custom agent files (Kimi-specific; retained for reference)
│   └── superpowers/
│       ├── agent.yaml
│       ├── system.md
│       ├── coder.yaml
│       ├── explore.yaml
│       └── plan.yaml
├── prompts/              # Prompt templates for project-level reminders
│   ├── superpowers-reminder.md
│   └── AGENTS.md.template
└── workflow/             # Universal Development Workflow documents
    ├── CONFIGURATION.md
    ├── README.md
    └── UNIVERSAL_WORKFLOW.md
```

## Updating

To update Superpowers to the latest version:

```bash
cd ~/.config/opencode/superpowers
git pull
```

Skills are linked (not copied), so they update automatically.

## Uninstallation

See the "Uninstallation" section in `SKILL.md` for detailed steps.

## Compatibility

- **OpenCode**: Any modern version with the `skill` tool
- **Windows**: PowerShell with junction support
- **macOS**: Any modern version
- **Linux**: Any modern distribution

## Credits

- [Superpowers](https://github.com/awdemos/opencode-superpowers) by Jesse Vincent
- [OpenCode](https://github.com/opencode-ai/opencode/)
- Original Kimi adapter by [Dqz00116](https://github.com/Dqz00116)

## License

MIT (same as Superpowers)

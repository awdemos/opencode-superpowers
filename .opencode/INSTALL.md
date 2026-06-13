# Installing Superpowers for OpenCode

## Prerequisites

- [OpenCode.ai](https://opencode.ai) installed

## Recommended Install

Add the upstream Superpowers plugin to the `plugin` array in your `opencode.json` (global or project-level):

```json
{
  "plugin": ["superpowers@git+https://github.com/obra/superpowers.git"]
}
```

Restart OpenCode. The plugin installs through OpenCode's plugin manager and registers all skills automatically.

Verify by asking: _"Tell me about your superpowers"_.

OpenCode uses its own plugin install. If you also use Claude Code, Codex, or another harness, install Superpowers separately for each one.

## Optional: Project-Level Templates

This repository (`opencode-superpowers`) provides optional project-level templates that complement the plugin:

| File | Purpose |
|------|---------|
| `prompts/AGENTS.md.template` | Project-level reminder to load the workflow and invoke skills. Copy to your project root as `AGENTS.md`. |
| `templates/PROJECT_CONFIG.yaml` | **Copy this** to your project root as `PROJECT_CONFIG.yaml` and fill in your stack. |
| `workflow/UNIVERSAL_WORKFLOW.md` | The full 7-stage feature / 4-phase debug workflow. |
| `workflow/CONFIGURATION.md` | A guide explaining every key in `PROJECT_CONFIG.yaml`. |

## Migrating from the Old Symlink-Based Install

If you previously installed Superpowers using `git clone` and symlinks, remove the old setup:

```bash
# Remove old symlinks
rm -f ~/.config/opencode/plugins/superpowers.js
rm -rf ~/.config/opencode/skills/superpowers

# Optionally remove the cloned repo
rm -rf ~/.config/opencode/superpowers

# Remove any skills.paths entry you added to opencode.json for superpowers
```

Then follow the recommended install above.

## Updating

OpenCode installs Superpowers through a git-backed package spec. Some OpenCode and Bun versions pin the resolved git dependency in a lockfile or cache, so a restart may not pick up the newest Superpowers commit. If updates do not appear, clear OpenCode's package cache or reinstall the plugin.

To pin a specific version:

```json
{
  "plugin": ["superpowers@git+https://github.com/obra/superpowers.git#v5.0.3"]
}
```

## Troubleshooting

### Plugin not loading

1. Check logs: `opencode run --print-logs "hello" 2>&1 | grep -i superpowers`
2. Verify the plugin line in your `opencode.json`
3. Make sure you're running a recent version of OpenCode

### Windows install issues

Some Windows OpenCode builds have upstream installer issues with git-backed plugin specs, including cache paths for `git+https` URLs and Bun not finding `git.exe` even when it works in a normal terminal. If OpenCode cannot install the plugin, try installing with system npm and pointing OpenCode at the local package:

```powershell
npm install superpowers@git+https://github.com/obra/superpowers.git --prefix "$HOME\.config\opencode"
```

Then use the installed package path in `opencode.json`:

```json
{
  "plugin": ["~/.config/opencode/node_modules/superpowers"]
}
```

### Skills not found

1. Use the `skill` tool to list discovered skills.
2. Check that the plugin is loading (see above).

### Tool mapping

When Superpowers skills reference Claude Code tools:

- `TodoWrite` → `todowrite`
- `Task` with subagents → OpenCode's subagent system (`@mention` syntax)
- `Skill` tool → OpenCode's native `skill` tool
- File operations → your native OpenCode tools

## Getting Help

- Report issues: https://github.com/obra/superpowers/issues
- Full documentation: https://github.com/obra/superpowers/blob/main/docs/README.opencode.md
- This installer repo: https://github.com/YOUR_USERNAME/opencode-superpowers

---
name: install-superpowers-for-opencode
description: Use when installing or migrating the Superpowers workflow for OpenCode, or when the agent needs project-level workflow templates to complement the upstream plugin.
---

# Install Superpowers for OpenCode

This skill guides you through installing the Superpowers workflow system for [OpenCode](https://opencode.ai).

Superpowers is a workflow system for AI coding assistants that enforces best practices like:

- Test-Driven Development (TDD)
- Systematic debugging
- Structured planning
- Subagent-driven development

## Recommended Install: Upstream OpenCode Plugin

The official Superpowers project ships a native OpenCode plugin. This is the preferred install method.

1. Add Superpowers to the `plugin` array in your `opencode.json` (global or project-level):

   ```json
   {
     "plugin": ["superpowers@git+https://github.com/obra/superpowers.git"]
   }
   ```

2. Restart OpenCode. The plugin installs through OpenCode's plugin manager and registers all Superpowers skills automatically.

3. Verify by asking: _"Tell me about your superpowers"_.

For full plugin documentation, see the [upstream OpenCode guide](https://github.com/obra/superpowers/blob/main/docs/README.opencode.md).

## Legacy Manual Install (Not Recommended)

Only use these steps if you cannot use the plugin for some reason (for example, an older OpenCode build without plugin support).

### Step 1: Clone the Superpowers Repository

```bash
mkdir -p ~/.config/opencode
# Clone from the vendored installer repo (or use obra/superpowers for upstream)
git clone --depth 1 https://github.com/awdemos/opencode-superpowers.git ~/.config/opencode/superpowers
```

**Windows (PowerShell):**

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode"
git clone --depth 1 https://github.com/awdemos/opencode-superpowers.git "$env:USERPROFILE\.config\opencode\superpowers"
```

### Step 2: Create Skill Links

**macOS/Linux:**

```bash
mkdir -p ~/.config/opencode/skills

for skill in brainstorming dispatching-parallel-agents executing-plans \
    finishing-a-development-branch receiving-code-review requesting-code-review \
    subagent-driven-development systematic-debugging test-driven-development \
    using-git-worktrees using-superpowers verification-before-completion \
    writing-plans writing-skills; do
    ln -sf ~/.config/opencode/superpowers/skills/$skill ~/.config/opencode/skills/$skill
done
```

**Windows (PowerShell as Administrator):**

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode\skills"

$skills = @(
    "brainstorming", "dispatching-parallel-agents", "executing-plans",
    "finishing-a-development-branch", "receiving-code-review", "requesting-code-review",
    "subagent-driven-development", "systematic-debugging", "test-driven-development",
    "using-git-worktrees", "using-superpowers", "verification-before-completion",
    "writing-plans", "writing-skills"
)

foreach ($skill in $skills) {
    $target = "$env:USERPROFILE\.config\opencode\skills\$skill"
    $source = "$env:USERPROFILE\.config\opencode\superpowers\skills\$skill"
    if (Test-Path $target) { Remove-Item $target -Recurse -Force }
    cmd /c mklink /J "$target" "$source"
}
```

### Step 3: Patch `using-superpowers` for OpenCode

Edit `~/.config/opencode/superpowers/skills/using-superpowers/SKILL.md`:

1. Change the description to:

   ```yaml
   description: MANDATORY — Read this skill FIRST at the start of EVERY conversation before any response or action
   ```

2. In the "How to Access Skills" section, add OpenCode-specific instructions after "In Kimi Code CLI:":

   ```markdown
   **In OpenCode:** Use the native `skill` tool to invoke skills. When a skill is invoked, follow its instructions exactly. You can also use `skill(name=\"<skill-name>\")` inline where appropriate.
   ```

3. In "The Rule" section, add after the first paragraph:

   ```markdown
   **In OpenCode specifically:** Before responding to the user's first message in any conversation, you MUST invoke the `using-superpowers` skill using the `skill` tool. Then, if any other skill might apply, invoke that skill as well. Do not skip this step.
   ```

## Optional: Project-Level Workflow Templates

If you want the Universal Workflow documents and a project-level reminder in addition to the plugin:

1. Copy the workflow files into your project:

   ```bash
   cp /path/to/opencode-superpowers/workflow/UNIVERSAL_WORKFLOW.md your-project/workflow/
   cp /path/to/opencode-superpowers/workflow/CONFIGURATION.md your-project/workflow/
   ```

2. Copy the project config template (this is **not** the guide in `workflow/CONFIGURATION.md`):

   ```bash
   cp /path/to/opencode-superpowers/templates/PROJECT_CONFIG.yaml your-project/PROJECT_CONFIG.yaml
   ```

3. Edit `PROJECT_CONFIG.yaml` with your stack details.

4. Copy the project reminder into your project root:

   ```bash
   cp /path/to/opencode-superpowers/prompts/AGENTS.md.template your-project/AGENTS.md
   ```

5. Replace the `PROJECT_NAME` placeholder with your project name.

## Migrating from the Legacy Symlink Install

If you previously used the symlink-based install and are switching to the plugin, remove the old setup:

```bash
# Remove old symlinks
rm -f ~/.config/opencode/plugins/superpowers.js
rm -rf ~/.config/opencode/skills/superpowers

# Optionally remove the cloned repo
rm -rf ~/.config/opencode/superpowers

# Remove any skills.paths entry you added to opencode.json for superpowers
```

Then follow the recommended plugin install above.

## Verification

1. Verify the plugin is listed in your `opencode.json` plugin array.
2. Restart OpenCode.
3. Ask: _"Tell me about your superpowers"_ and confirm the agent mentions the workflow.
4. If you added project-level templates, start OpenCode in that project and confirm the agent reads `workflow/UNIVERSAL_WORKFLOW.md` and `using-superpowers` before responding.

## Uninstallation

### Plugin Install

Remove the plugin line from `opencode.json` and restart OpenCode.

### Legacy Install

1. Remove skill links:

   ```bash
   rm -rf ~/.config/opencode/skills/*
   ```

2. Remove the cloned repository:

   ```bash
   rm -rf ~/.config/opencode/superpowers
   ```

3. Remove `AGENTS.md` files from projects where they were added.

## Troubleshooting

**Plugin not loading:**

- Check OpenCode logs: `opencode run --print-logs "hello" 2>&1 | grep -i superpowers`
- Verify the plugin line in `opencode.json`.
- Make sure you are running a recent version of OpenCode.

**Skills not showing up (legacy install):**

- Check that symlinks/junctions were created correctly: `ls -la ~/.config/opencode/skills/`
- Verify the Superpowers repo was cloned: `ls ~/.config/opencode/superpowers/skills/`

**Permission denied on Windows:**

- Creating junctions requires Administrator privileges. Run PowerShell as Administrator.

## For AI Assistants Using This Workflow

When this skill is invoked, you are being asked to install or configure Superpowers for OpenCode. Use the plugin-first instructions above unless the user explicitly asks for the legacy install.

After installation, guide the user to:

1. Use the OpenCode `skill` tool to invoke Superpowers skills.
2. Create `PROJECT_CONFIG.yaml` from `templates/PROJECT_CONFIG.yaml` if they want project-level workflow commands.
3. Copy `prompts/AGENTS.md.template` into their project root if they want a local reminder.
4. Read `workflow/UNIVERSAL_WORKFLOW.md` to understand the process.

---

*Skill Version: 2.0 | OpenCode plugin-first*

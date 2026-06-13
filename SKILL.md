---
name: install-superpowers-for-opencode
description: Install and configure Superpowers workflow for OpenCode (universal AI assistant conventions)
---

# Install Superpowers for OpenCode

This skill guides you through installing the Superpowers workflow system for OpenCode.

## What is Superpowers?

Superpowers is a workflow system for AI coding assistants that enforces best practices like:

- Test-Driven Development (TDD)
- Systematic debugging
- Structured planning
- Subagent-driven development

## How OpenCode Differs from Kimi

OpenCode already has a native `skill` tool, so skill invocation is simpler than in Kimi. The main adaptation is:

- Skills are placed in `~/.config/opencode/skills/`.
- The user invokes the top-level skill (this one) to install Superpowers.
- A project-level `AGENTS.md` template is provided to remind the agent to load the Universal Workflow and invoke Superpowers skills at the start of each conversation.
- There is no `inject_prompt` hook in OpenCode; the `AGENTS.md` mechanism is the recommended per-project reminder.

## Installation Steps

### Step 1: Ensure OpenCode is Installed

This skill assumes OpenCode is installed and available on your system. If not, install it from the official source first.

### Step 2: Clone Superpowers Repository

```bash
# Create opencode directory if it doesn't exist
mkdir -p ~/.config/opencode

# Clone superpowers repository
git clone --depth 1 https://github.com/obra/superpowers.git ~/.config/opencode/superpowers
```

**Windows (PowerShell):**

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode"
git clone --depth 1 https://github.com/obra/superpowers.git "$env:USERPROFILE\.config\opencode\superpowers"
```

### Step 3: Create Skill Links

**On macOS/Linux:**

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

**On Windows (PowerShell as Administrator):**

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

### Step 4: Patch using-superpowers Skill for OpenCode

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

### Step 5: Configure Project Reminder (AGENTS.md)

Unlike Kimi, OpenCode does not have a global `inject_prompt` hook. Instead, place a project-level `AGENTS.md` in repositories where you want Superpowers enforced.

A template is provided in this repository at `prompts/AGENTS.md.template`. Copy it to your project root:

```bash
cp /path/to/opencode-superpowers/prompts/AGENTS.md.template /path/to/your/project/AGENTS.md
```

Then customize the `PROJECT_NAME` placeholder.

### Step 6: Install Universal Workflow (Optional but Recommended)

If you want the universal workflow structure in your projects:

```bash
# Clone this repository
git clone https://github.com/YOUR_USERNAME/opencode-superpowers.git

# Copy workflow files to your project
cp opencode-superpowers/workflow/UNIVERSAL_WORKFLOW.md your-project/workflow/
cp opencode-superpowers/workflow/CONFIGURATION.md your-project/workflow/

# Create your project config
cp opencode-superpowers/workflow/CONFIGURATION.md your-project/PROJECT_CONFIG.yaml
# Edit PROJECT_CONFIG.yaml with your stack details
```

## Verification

1. **Verify skills are linked:**

   ```bash
   ls -la ~/.config/opencode/skills/
   ```

2. **Start OpenCode in a project with the `AGENTS.md` template.**

   The agent should mention the Superpowers workflow and read `using-superpowers/SKILL.md` before responding.

## For AI Assistants Using This Workflow

When this skill is invoked, you are being asked to install Superpowers for OpenCode. Follow the steps above for the user's platform.

After installation, guide the user to:

1. Create `PROJECT_CONFIG.yaml` for their project (see `workflow/CONFIGURATION.md`).
2. Read `workflow/UNIVERSAL_WORKFLOW.md` to understand the process.
3. Copy `prompts/AGENTS.md.template` into their project root.
4. Start using the workflow for their development tasks.

## Uninstallation

1. **Remove skill links:**

   ```bash
   rm -rf ~/.config/opencode/skills/*
   ```

2. **Remove superpowers repository:**

   ```bash
   rm -rf ~/.config/opencode/superpowers
   ```

3. **Remove AGENTS.md files** from projects where they were added.

## Troubleshooting

**Skills not showing up:**

- Check that symlinks/junctions were created correctly: `ls -la ~/.config/opencode/skills/`
- Verify the superpowers repo was cloned: `ls ~/.config/opencode/superpowers/skills/`

**Permission denied on Windows:**

- Creating junctions requires Administrator privileges on Windows. Run PowerShell as Administrator.

**OpenCode can't find skills:**

- OpenCode looks for skills in `~/.config/opencode/skills/` by default.
- Make sure the directory exists and contains the skill links.

---

*Skill Version: 1.0 | Adapted for OpenCode*

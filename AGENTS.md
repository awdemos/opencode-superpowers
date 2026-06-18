# Agent Notes: opencode-superpowers

This repository is an **OpenCode skill installer** for the Superpowers workflow. It is not an application—there is nothing to build, test, or run.

## Entry points

- **`SKILL.md`** is the canonical source of truth. It is the OpenCode skill definition that tells an agent how to install and configure Superpowers.
- **`README.md`** is the user-facing overview. Keep it in sync with `SKILL.md` when installation steps or repository structure change.

## Repository layout

- `SKILL.md` — OpenCode skill definition (main entry point).
- `prompts/AGENTS.md.template` — Template for project-level `AGENTS.md` files. Copied into *other* projects, not used in this repo.
- `prompts/superpowers-reminder.md` — Inline system-reminder-style prompt template, also for *other* projects.
- `agents/` — Intentionally empty. OpenCode does not use Kimi-style agent config files; do not add them here.

## Conventions

- **No build/test/lint commands exist.** Do not attempt to run `npm test`, `pytest`, `make`, etc.
- Changes to installation logic must be reflected in both `SKILL.md` and `README.md`.
- Preserve the distinction between this repo's own docs and the templates in `prompts/` that users copy elsewhere.

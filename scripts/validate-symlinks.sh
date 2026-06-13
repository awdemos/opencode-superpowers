#!/usr/bin/env bash
# scripts/validate-symlinks.sh
# Verifies the legacy symlink-based install for local debugging.
set -euo pipefail

skills_home="${HOME}/.config/opencode/skills"
superpowers_dir="${HOME}/.config/opencode/superpowers"
errors=0

if [[ ! -d "$superpowers_dir" ]]; then
  echo "MISSING: $superpowers_dir (legacy clone target)"
  ((errors++)) || true
fi

for skill in brainstorming dispatching-parallel-agents executing-plans \
  finishing-a-development-branch receiving-code-review requesting-code-review \
  subagent-driven-development systematic-debugging test-driven-development \
  using-git-worktrees using-superpowers verification-before-completion \
  writing-plans writing-skills; do
  link="$skills_home/$skill"
  if [[ ! -e "$link" ]]; then
    echo "MISSING LINK: $link -> $superpowers_dir/skills/$skill"
    ((errors++)) || true
  fi
done

if (( errors > 0 )); then
  echo "Found $errors symlink/install issue(s)."
  exit 1
fi

echo "Legacy symlink install OK."

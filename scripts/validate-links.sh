#!/usr/bin/env bash
# scripts/validate-links.sh
# Validates relative .md links inside the repository (excluding internal plans/docs).
set -uo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

broken_count=0

while IFS= read -r -d '' file; do
  src_dir="$(dirname "$file")"
  while IFS= read -r link; do
    [[ -z "$link" ]] && continue
    target_raw="$(echo "$link" | sed -E 's/.*\]\(([^)]+)\)/\1/')"
    # strip fragment and query
    target="${target_raw%%#*}"
    target="${target%%\?*}"
    [[ -z "$target" ]] && continue
    # skip external and mailto links
    [[ "$target" =~ ^(https?|mailto|file):// ]] && continue
    resolved="$src_dir/$target"
    if [[ ! -e "$resolved" ]]; then
      echo "BROKEN: $file -> $target (resolved: $resolved)"
      broken_count=$((broken_count + 1))
    fi
  done < <(grep -oE '\[([^]]+)\]\(([^)]+)\)' "$file" 2>/dev/null || true)
done < <(find . -name '*.md' -not -path './docs/*' -not -path './skills/*' -print0)

if (( broken_count > 0 )); then
  echo "Found $broken_count broken internal link(s)."
  exit 1
fi

echo "All internal markdown links OK."

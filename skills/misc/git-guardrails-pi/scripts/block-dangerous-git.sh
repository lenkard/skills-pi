#!/usr/bin/env bash
set -euo pipefail

REAL_GIT="${REAL_GIT:-$(command -v git)}"
SCRIPT_PATH="$(readlink -f "$0" 2>/dev/null || realpath "$0" 2>/dev/null || echo "$0")"
REAL_GIT_PATH="$(readlink -f "$REAL_GIT" 2>/dev/null || realpath "$REAL_GIT" 2>/dev/null || echo "$REAL_GIT")"

# If command -v git resolves back to this wrapper, find the next git on PATH.
if [ "$REAL_GIT_PATH" = "$SCRIPT_PATH" ]; then
  while IFS= read -r candidate; do
    candidate_path="$(readlink -f "$candidate" 2>/dev/null || realpath "$candidate" 2>/dev/null || echo "$candidate")"
    if [ "$candidate_path" != "$SCRIPT_PATH" ]; then
      REAL_GIT="$candidate"
      break
    fi
  done < <(which -a git)
fi

COMMAND="git $*"
DANGEROUS_PATTERNS=(
  '^git push( |$)'
  '^git reset --hard( |$)'
  '^git clean -f(d)?( |$)'
  '^git branch -D( |$)'
  '^git checkout \.( |$)'
  '^git restore \.( |$)'
  'push .*--force'
  'reset --hard'
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if printf '%s\n' "$COMMAND" | grep -qE "$pattern"; then
    echo "BLOCKED: '$COMMAND' matches dangerous pattern '$pattern'. Ask the user for explicit confirmation before bypassing this guardrail." >&2
    exit 2
  fi
done

exec "$REAL_GIT" "$@"

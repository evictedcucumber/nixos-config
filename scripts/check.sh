#!/usr/bin/env bash
# check.sh — run the same formatting/lint/eval checks as `nix flake check`
# Usage: ./scripts/check.sh [--fix]
#   --fix   run `nix fmt` first to apply formatting/lint fixes, then check

set -euo pipefail

FLAKE="${FLAKE_PATH:-.}"

if [[ "${1:-}" == "--fix" ]]; then
  printf "\033[1m\033[0;36m→ nix fmt\033[0m\n"
  nix fmt "$FLAKE"
fi

printf "\033[1m\033[0;36m→ nix flake check\033[0m\n"
nix flake check "$FLAKE"

#!/usr/bin/env bash
# show-modules.sh — display home-manager module states for a host
# Usage: ./show-modules.sh [hostname|all]   (defaults to all hosts)

set -euo pipefail

FLAKE="${FLAKE_PATH:-.}"
HOSTS=("seamoth" "snowfox" "tadpole")

usage() {
  echo "Usage: $0 [hostname|all]"
  echo "  hostname: one of ${HOSTS[*]}"
  echo "  all:      show all hosts (default)"
  echo ""
  echo "Environment:"
  echo "  FLAKE_PATH  path to your flake (default: .)"
}

show_host() {
  local host="$1"
  printf "\n\033[1m\033[0;36m══════════════════════════════════════════\033[0m\n"
  printf "\033[1m\033[0;36m  Host: %s\033[0m\n" "$host"
  printf "\033[1m\033[0;36m══════════════════════════════════════════\033[0m\n"

  local me_json
  if ! me_json=$(nix eval --json \
    "${FLAKE}#nixosConfigurations.${host}.config.home-manager.users.ethan.me" \
    2>/dev/null); then
    printf "  \033[0;31m✗ Failed to evaluate — nix eval errored\033[0m\n"
    return
  fi

  echo "$me_json" | python3 -c "
import json, sys

# Scalar types we know how to display as a single value.
# Anything else (dict/list) gets recursed into.
SCALAR = (bool, int, float, str, type(None))

def is_leaf(val):
    # A dict is a leaf if ALL its values are scalars (i.e. it is a settings
    # record, not another level of module nesting).  We still recurse into
    # dicts that contain nested dicts so module groups are kept together.
    if not isinstance(val, dict):
        return True
    return all(isinstance(v, SCALAR) for v in val.values())

def fmt_val(val):
    if val is None:
        return '\033[2mnull\033[0m'
    if isinstance(val, bool):
        if val:
            return '\033[0;32mtrue\033[0m'
        return '\033[0;31mfalse\033[0m'
    if isinstance(val, str):
        if val == '':
            return '\033[2m(empty string)\033[0m'
        return f'\033[0;33m\"{val}\"\033[0m'
    if isinstance(val, (int, float)):
        return f'\033[0;33m{val}\033[0m'
    if isinstance(val, dict):
        # Inline small records like {name=..., email=...}
        parts = ', '.join(f'{k}: {fmt_val(v)}' for k, v in sorted(val.items()))
        return '{ ' + parts + ' }'
    if isinstance(val, list):
        return '[' + ', '.join(fmt_val(v) for v in val) + ']'
    return repr(val)

def walk(obj, path='', depth=0):
    indent = '  ' + '  ' * depth

    if not isinstance(obj, dict):
        # Bare scalar at top level — shouldn't normally happen but handle it
        print(f'{indent}\033[0;37m{path}\033[0m = {fmt_val(obj)}')
        return

    # Separate keys into:
    #   enable_key  — the 'enable' boolean for this module group
    #   scalar_keys — flat option values (str, int, bool non-enable, null)
    #   nested_keys — dicts that contain further dicts (sub-module groups)
    enable_val = obj.get('enable', None)
    keys = sorted(obj.keys())

    # Print the group header + enable status
    if path:
        if enable_val is not None:
            flag = '\033[0;32m✓\033[0m' if enable_val else '\033[0;31m✗\033[0m'
            print(f'{indent}{flag} \033[1m{path}\033[0m')
        else:
            print(f'{indent}\033[1m{path}\033[0m')

    sub_indent = '  ' + '  ' * (depth + 1)

    for key in keys:
        if key == 'enable':
            continue  # already printed above
        val = obj[key]
        full = f'{path}.{key}' if path else key

        if isinstance(val, dict) and any(isinstance(v, dict) for v in val.values()):
            # Nested module group — recurse
            walk(val, key if not path else key, depth + 1)
        else:
            # Leaf value (scalar, list, or flat record)
            print(f'{sub_indent}\033[2m{key}\033[0m = {fmt_val(val)}')

data = json.load(sys.stdin)
walk(data)
"
}

target="${1:-all}"

case "$target" in
  all)
    for host in "${HOSTS[@]}"; do
      show_host "$host"
    done
    ;;
  seamoth|snowfox|tadpole)
    show_host "$target"
    ;;
  -h|--help)
    usage
    ;;
  *)
    printf "\033[0;31mUnknown host: %s\033[0m\n" "$target"
    usage
    exit 1
    ;;
esac

printf "\n"

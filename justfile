# List recipes
default:
    @just --list

# Rebuild and switch to a host's config
switch host=`hostname`:
    sudo nixos-rebuild switch --flake .#{{ host }}

# Format the repo
fmt:
    nix fmt

# Format check, lint, and evaluate every host
check:
    nix flake check

# Update all flake inputs
update:
    nix flake update

# Show resolved me.* modules for a host
modules host="all":
    ./scripts/show-modules.sh {{ host }}

# Build seamoth's installer ISO into the current directory as seamoth.iso
generate host:
    @[ "{{ host }}" = seamoth ] || { echo "Only seamoth has an installer ISO" >&2; exit 1; }
    install -m 644 "$(nix build .#{{ host }}-iso --no-link --print-out-paths)"/iso/*.iso "{{ invocation_directory() }}/{{ host }}.iso"

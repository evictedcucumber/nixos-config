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

# Build a disko-managed host's installer ISO into the current directory as <host>.iso
generate host:
    @[ -f hosts/{{ host }}/disko.nix ] || { echo "{{ host }} has no disko layout, so no installer ISO" >&2; exit 1; }
    install -m 644 "$(nix build .#{{ host }}-iso --no-link --print-out-paths)"/iso/*.iso "{{ invocation_directory() }}/{{ host }}.iso"

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

# Build a host's installer into the current directory: <host>.iso for disko hosts, <host>.wsl for WSL hosts
generate host:
    #!/usr/bin/env bash
    set -euo pipefail
    out="{{ invocation_directory() }}/{{ host }}"
    if [ -f hosts/{{ host }}/disko.nix ]; then
        install -m 644 "$(nix build .#{{ host }}-iso --no-link --print-out-paths)"/iso/*.iso "$out.iso"
    elif nix eval .#{{ host }}-wsl.name >/dev/null 2>&1; then
        builder="$(nix build .#{{ host }}-wsl --no-link --print-out-paths)"
        sudo "$builder/bin/nixos-wsl-tarball-builder" "$out.wsl"
        sudo chown "$(id -u):$(id -g)" "$out.wsl"
    else
        echo "{{ host }} is neither a disko nor a WSL host, so there is nothing to generate" >&2
        exit 1
    fi

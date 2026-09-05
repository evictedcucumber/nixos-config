# nixos-config

My personal NixOS + Home Manager configuration, managed as a single flake across all my machines.

## Layout

```
flake.nix              Inputs and the nixosConfigurations for each host
utilities/
  mkSystem.nix          Builds a nixosSystem from {system, hostname, username, stateVersion}
  mkSymlink.nix          Out-of-store symlink helper for dotfiles kept under config/
systems/
  default.nix            Settings shared by every host (nix.settings, locale, users, ...)
  <host>.nix              Per-host NixOS config (hardware, services, home-manager import)
  wsl.nix                  Shared base for WSL hosts (imported by snowfox/tadpole)
home/
  default.nix             Home Manager options shared by every host, under the `me.*` namespace
  <host>.nix                Per-host Home Manager delta, imported on top of default.nix
  modules/                One file per tool/app, grouped by category (editors/, tools/, wms/, ...)
config/                  Raw dotfiles (Hyprland, yazi, fish theme, ...) symlinked into place
scripts/
  show-modules.sh         Prints which `me.*` options are enabled per host
```

## The `me.*` pattern

Every optional piece of Home Manager config (an editor, a CLI tool, a WM, ...) lives in its own
file under `home/modules/`, declares a `me.<category>.<name>.enable` option (plus any settings it
needs), and wires up the real `programs.*`/`home.*` config behind `lib.mkIf`. `import-tree` pulls
every file under `home/modules/` in automatically, so adding a new module is just adding a file —
no import list to maintain.

`home/default.nix` sets the `me.*` options common to all hosts; each `home/<host>.nix` imports it
and layers host-specific deltas (extra apps, per-host git signing key, etc.) on top. Run
`./scripts/show-modules.sh [hostname|all]` to see the resolved `me.*` tree for a host without
doing a full rebuild.

## Hosts

| Host      | Type              | Notes                                                        |
| --------- | ----------------- | ------------------------------------------------------------- |
| `seamoth` | Bare-metal desktop | LUKS + btrfs/snapper, Hyprland, gaming (Steam), libvirt        |
| `snowfox` | WSL                | Personal WSL machine                                         |
| `tadpole` | WSL                | Work WSL machine (adds VS SSH config)                         |

## Usage

```bash
sudo nixos-rebuild switch --flake .#<host>
# or, since `me.tools.nh` is enabled:
nh os switch
```

### Checks

This flake wires up [`treefmt-nix`](https://github.com/numtide/treefmt-nix) with `alejandra`
(formatting), `statix` and `deadnix` (linting):

```bash
nix fmt          # format the repo
nix flake check  # format-check + lint, plus evaluate every host's config
```

## License

MIT, see [LICENSE](LICENSE).

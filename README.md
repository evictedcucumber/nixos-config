# nixos-config

My personal NixOS + Home Manager configuration, managed as a single flake across all my machines.

## Layout

```
flake.nix              Inputs and the flake-parts setup (formatter, dev shell, checks)
hosts/
  default.nix            Turns every directory here into a nixosConfiguration (and an ISO if it has a disko.nix)
  <host>/
    default.nix            Per-host NixOS config, including its stateVersion
    home.nix               Per-host Home Manager config: the profiles it imports plus its own settings
    hardware.nix           Hardware config for bare-metal hosts, like nixos-generate-config's output
    disko.nix              Declarative disk layout (partitions, LUKS, LVM, btrfs) for bare-metal hosts
modules/
  nixos/
    default.nix            Settings shared by every host; imports nix.nix, locale.nix and security.nix
    wsl.nix                Shared base for WSL hosts (imported by snowfox/tadpole)
    installer.nix          Installer ISO that formats and installs a disko-managed host offline
    desktop/               Graphical session for non-WSL hosts: Hyprland + greetd, audio, power profiles
  home/
    default.nix            Home Manager settings shared by every host
    profiles/              cli.nix, dev.nix (builds on cli) and desktop.nix
    programs/              One file per program that needs real configuration, plus theme.nix
lib/
  mkSystem.nix           Builds a nixosSystem from {system, hostname, username}
  mkSymlink.nix          Out-of-store symlink helper for dotfiles kept under config/
  mkPathCheck.nix        Activation check that a cloned repo is where its option says
config/                  Raw dotfiles (Hyprland, yazi, fish theme, ...) symlinked into place
scripts/
  check.sh               Runs the same format/lint/eval checks as `nix flake check`
justfile                Shortcuts for the commands below (`just` lists them)
lefthook.yml            Git hook config (see Checks below)
```

## Profiles

Home Manager config is grouped into three profiles under `modules/home/profiles/`:

- `cli.nix`: shell, prompt and everyday command-line tools.
- `dev.nix`: Neovim, compilers and language toolchains. It imports `cli.nix`.
- `desktop.nix`: the Hyprland session, theming and graphical apps.

A profile lists plain packages itself and imports a file from `modules/home/programs/` for anything
that needs real configuration. Each `hosts/<host>/home.nix` imports the profiles it wants and adds
its own settings on top. Two options cover what differs per host: `me.git.signingKey` and
`me.ssh.extraConfig`.

Dotfiles under `config/` and the Neovim config are symlinked from their clones instead of being
copied into the Nix store, so edits apply without a rebuild. `me.flakePath` (default
`~/repos/nixos-config`) and `me.neovimConfigPath` (default `~/repos/neovim-config`) say where those
clones are. If either is missing, Home Manager activation fails with a message naming the option,
after everything else has been set up.

To add a host, create `hosts/<name>/default.nix` and `hosts/<name>/home.nix`; it is picked up
automatically.

## Hosts

| Host      | Type              | Notes                                                        |
| --------- | ----------------- | ------------------------------------------------------------- |
| `seamoth` | Bare-metal desktop | LUKS + btrfs/snapper, Hyprland, gaming (Steam), libvirt        |
| `snowfox` | WSL                | Personal WSL machine                                         |
| `tadpole` | WSL                | Work WSL machine (adds VS SSH config)                         |

## Usage

```bash
sudo nixos-rebuild switch --flake .#<host>
# or, with `nh` from the cli profile:
nh os switch
# or
just switch [host]
```

### Installing seamoth from scratch

```bash
just generate seamoth   # writes seamoth.iso, with seamoth's full system baked in, to the current directory
```

Write the ISO to a USB stick, boot the laptop from it, and run `sudo install-seamoth`. It asks you to
confirm before wiping `/dev/nvme0n1`, prompts for the LUKS passphrase, installs seamoth without
needing the network, and finally asks for a password for `ethan`. After that, `nixos-rebuild switch
--flake .#seamoth` rebuilds as usual: disko only formats when the install script runs it.

### Checks

This flake wires up [`treefmt-nix`](https://github.com/numtide/treefmt-nix) with `alejandra`
(formatting), `statix` and `deadnix` (linting):

```bash
nix fmt          # format the repo
nix flake check  # format-check + lint, plus evaluate every host's config

./scripts/check.sh          # same as `nix flake check`, with a friendlier banner
./scripts/check.sh --fix    # nix fmt, then check
```

Git hooks are managed with [lefthook](https://lefthook.dev) (installed by the dev profile and the
dev shell). Entering the dev shell wires them up; outside it, run `lefthook install` once per clone:

- `pre-commit` runs `nix fmt` on staged `.nix` files and re-stages anything it reformats.
- `pre-push` runs the full `nix flake check` (format check + statix + deadnix + evaluate every
  host).

## License

MIT, see [LICENSE](LICENSE).

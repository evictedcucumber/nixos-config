# Installer ISO for a disko-managed host. `target` is that host's nixosConfiguration;
# its system closure is baked in, so `install-<host>` works offline.
{
  lib,
  modulesPath,
  pkgs,
  target,
  username,
  ...
}: let
  inherit (target.config.networking) hostName;
  inherit (target.config.system.build) diskoScript toplevel;
  disks = lib.concatMapStringsSep " " (d: d.device) (lib.attrValues target.config.disko.devices.disk);
in {
  imports = ["${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"];

  nixpkgs.hostPlatform = target.pkgs.stdenv.hostPlatform.system;

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "install-${hostName}" ''
      set -euo pipefail
      read -rp "This erases ${disks}. Type 'yes' to continue: " answer
      [ "$answer" = yes ] || { echo "Aborted."; exit 1; }
      ${diskoScript}
      nixos-install --no-root-passwd --no-channel-copy --system ${toplevel}
      echo "Set the password for ${username}:"
      until nixos-enter --root /mnt -c 'passwd ${username}'; do
        echo "Try again."
      done
    '')
  ];
}

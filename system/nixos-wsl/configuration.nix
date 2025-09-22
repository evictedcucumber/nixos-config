{
  pkgs,
  nixos-wsl,
  ...
}: let
  obsidianVaultSyncScript = pkgs.writeShellScript "obsidian-vault-sync" ''
    #/usr/bin/env bash

    ${pkgs.unison}/bin/unison \
      -root "/mnt/c/Users/ethan/OneDrive/[97] Obsidian Vault" \
      -root "/home/ethan/myvault" \
      -batch -prefer=newer -fat -auto -confirmbigdel
  '';
in {
  imports = [
    ../../system
    nixos-wsl.nixosModules.wsl
  ];

  wsl.enable = true;
  wsl.defaultUser = "ethan";

  programs.fish.enable = true;
  users.users."ethan" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.fish;
  };
  nix.settings.trusted-users = ["ethan"];

  environment.systemPackages = with pkgs; [unison];
  systemd.user.services."obsidian-vault-sync" = {
    description = "Run obsidian-vault-sync.sh to sync obsidian vault";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = obsidianVaultSyncScript;
    };
  };
  systemd.user.timers."obsidian-vault-sync" = {
    timerConfig = {
      OnBootSec = "30s";
      OnUnitActiveSec = "30s";
    };
    wantedBy = ["timers.target"];
  };
}

{
  pkgs,
  nixos-wsl,
  username,
  ...
}: let
  obsidianVaultSyncScript = pkgs.writeShellScript "obsidian-vault-sync" ''
    #/usr/bin/env bash

    ${pkgs.unison}/bin/unison \
      -root "/mnt/c/Users/${username}/Documents/My Obsidian Vault" \
      -root "/home/${username}/myvault" \
      -batch -prefer=newer -fat -auto -confirmbigdel
  '';
in {
  imports = [
    ../../system
    nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    defaultUser = "${username}";
    interop.includePath = false;
  };

  programs.fish.enable = true;
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.fish;
  };
  nix.settings.trusted-users = ["${username}"];

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

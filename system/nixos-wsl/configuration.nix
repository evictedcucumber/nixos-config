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
      -prefer=newer -fat -confirmbigdel -auto -batch -repeat 2 \
      -fastcheck true
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
    description = "Sync obsidian vault between windows an wsl";
    after = ["default.target"];

    serviceConfig = {
      ExecStart = obsidianVaultSyncScript;
      Restart = "always";
      RestartSec = 5;
    };

    wantedBy = ["default.target"];
  };
}

{
  pkgs,
  nixos-wsl,
  ...
}: let
  unisonWatchScript = pkgs.writeShellScript "unison-watch" ''
    #/usr/bin/env bash

    while true; do
      ${pkgs.inotify-tools}/bin/inotifywait -r -e modify,create,delete,move "/mnt/c/Users/ethan/OneDrive/[97] Obsidian Vault" /home/ethan/myvault
      ${pkgs.unison}/bin/unison \
        -root "/mnt/c/Users/ethan/OneDrive/[97] Obsidian Vault" \
        -root "/home/ethan/myvault" \
        -batch -prefer=newer -fat
    done
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

  environment.systemPackages = with pkgs; [unison inotify-tools];
  systemd.user.services.unison-watch = {
    description = "Run unison-watch.sh to sync obsidian vault";
    serviceConfig = {
      ExecStart = unisonWatchScript;
      Restart = "always";
    };
    wantedBy = ["default.target"];
  };
}

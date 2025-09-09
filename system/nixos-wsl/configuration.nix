{
  pkgs,
  nixos-wsl,
  ...
}: let
  unisonScript = pkgs.writeShellScript "unison-watch" ''
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
  systemd.user.services."unison-watch" = {
    description = "Run unison-watch.sh to sync obsidian vault";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = unisonScript;
    };
  };
  systemd.user.timers."unison-watch" = {
    timerConfig = {
      OnBootSec = "30s";
      OnUnitActiveSec = "30s";
    };
    wantedBy = ["timers.target"];
  };
}

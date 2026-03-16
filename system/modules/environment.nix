{
  pkgs,
  username,
  lib,
  config,
  ...
}: {
  options.me.system.core.environment.enable = lib.mkEnableOption "Enable Environment Options";

  config = lib.mkIf config.me.system.core.environment.enable {
    environment = {
      systemPackages = with pkgs; [
        git
        git-lfs
        ncdu
        openssh
        pinentry-all
        xclip
        wezterm
      ];
      sessionVariables.NH_FLAKE = "/home/${username}/repos/nixos-config";
    };
  };
}

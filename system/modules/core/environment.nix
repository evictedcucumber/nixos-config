{
  pkgs,
  username,
  lib,
  config,
  ...
}: {
  options.me.system.core.environment = {
    enable = lib.mkEnableOption "Enable Environment Options";
    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Extra System Packages";
    };
  };

  config = lib.mkIf config.me.system.core.environment.enable {
    environment = {
      systemPackages = with pkgs;
        [
          git
          openssh
          pinentry-all
          xclip
        ]
        ++ config.me.system.core.environment.extraPackages;
      sessionVariables.NH_FLAKE = "/home/${username}/repos/nixos-config";
    };
  };
}

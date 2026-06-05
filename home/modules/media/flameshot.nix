{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.media.flameshot.enable = lib.mkEnableOption "Enable Flameshot";

  config = lib.mkIf config.me.media.flameshot.enable {
    services.flameshot = {
      enable = true;
      settings = {
        General = {
          useGrimAdapter = true;
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;
        };
      };
    };

    home.packages = [pkgs.grim];
  };
}

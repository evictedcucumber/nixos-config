{...}: {
  flake.homeModules.flameshot = {pkgs, ...}: {
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

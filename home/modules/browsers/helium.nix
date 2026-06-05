{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.browsers.helium.enable = lib.mkEnableOption "Enable Helium Browser";

  config = lib.mkIf config.me.browsers.helium.enable {
    home.packages = [pkgs.helium];
  };
}

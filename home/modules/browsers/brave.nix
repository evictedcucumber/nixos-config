{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.browsers.brave.enable = lib.mkEnableOption "Enable Brave Browser";

  config = lib.mkIf config.me.browsers.brave.enable {
    home.packages = [pkgs.brave];
  };
}

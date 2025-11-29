{
  lib,
  config,
  pkgs,
  zen-browser,
  ...
}: {
  options = {
    me.gui.zen-browser.enable = lib.mkEnableOption "Enable Zen Browser";
  };

  config = lib.mkIf config.me.gui.zen-browser.enable {
    home.packages = [zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default];
  };
}

{
  pkgs,
  config,
  lib,
  ...
}: {
  options.me.home.cli.bat.enable = lib.mkEnableOption "Enable Bat Options";

  config = lib.mkIf config.me.home.cli.bat.enable {
    home.packages = with pkgs;
      [bat]
      ++ (with pkgs.bat-extras; [
        batdiff
        batgrep
        batman
        batpipe
        batwatch
      ]);

    home.sessionVariables.BAT_THEME = "catppuccin";
  };
}

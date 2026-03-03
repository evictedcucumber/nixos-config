{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [bat]
    ++ (with pkgs.bat-extras; [
      batdiff
      batdiff
      batgrep
      batman
      batpipe
      batwatch
    ]);

  home.sessionVariables.BAT_THEME = "catppuccin";

  xdg.configFile."bat" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/nixos-config/config/bat";
    recursive = true;
  };
}

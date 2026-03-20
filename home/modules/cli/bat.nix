{pkgs, ...}: {
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
}

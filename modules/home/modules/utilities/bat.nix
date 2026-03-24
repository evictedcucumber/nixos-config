{...}: {
  flake.homeModules.bat = {pkgs, ...}: {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batgrep
        batman
        batpipe
        batwatch
      ];
      config = {
        theme = "Catppuccin Mocha";
      };
      themes.catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "main";
          sha256 = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };

    # home.sessionVariables.BAT_THEME = "catppuccin";
  };
}

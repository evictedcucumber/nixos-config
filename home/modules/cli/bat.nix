{pkgs, ...}: let
  batTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "main";
    sha256 = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
  };
in {
  programs.bat = {
    enable = true;
    config.theme = "catppuccin";
    syntaxes = {};
    themes.catppuccin = {
      src = batTheme;
      file = "themes/Catppuccin Mocha.tmTheme";
    };
  };
}

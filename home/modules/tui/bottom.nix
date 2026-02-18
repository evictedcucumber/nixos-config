{pkgs, ...}: let
  bottomTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bottom";
    rev = "main";
    sha256 = "sha256-dfukdk70ug1lRGADKBnvMhkl+3tsY7F+UAwTS2Qyapk=";
  };
in {
  programs.bottom.enable = true;

  xdg.configFile."bottom/bottom.toml".source = "${bottomTheme}/themes/mocha.toml";
}

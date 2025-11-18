{
  lib,
  config,
  pkgs,
  ...
}: let
  catpuccin_theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bottom";
    rev = "main";
    sha256 = "sha256-dfukdk70ug1lRGADKBnvMhkl+3tsY7F+UAwTS2Qyapk=";
  };
in {
  options = {me.cli.bottom.enable = lib.mkEnableOption "Enable bottom";};

  config = lib.mkIf config.me.cli.bottom.enable {
    programs.bottom.enable = true;
    home.file.".config/bottom/bottom.toml".source = "${catpuccin_theme}/themes/mocha.toml";
  };
}

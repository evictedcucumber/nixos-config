{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    me.cli.bat.enable = lib.mkEnableOption "Enable bat";
  };

  config = lib.mkIf config.me.cli.bat.enable {
    home.packages = with pkgs; [bat-extras.batman];

    home.sessionVariables = {
      BAT_THEME = "catppuccin";
    };

    programs.bat = {
      enable = true;
      themes = {
        catppuccin = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "main";
            sha256 = "sha256-6fWoCH90IGumAMc4buLRWL0N61op+AuMNN9CAR9/OdI=";
          };
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
    };
  };
}

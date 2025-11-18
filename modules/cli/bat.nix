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
    home.packages = with pkgs.bat-extras; [
      batman
      batdiff
      batgrep
      batpipe
      batdiff
      batwatch
    ];

    # home.sessionVariables = {
    #   BAT_THEME = "catppuccin";
    # };

    programs.bat = {
      enable = true;
      config = {
        theme = "catppuccin";
      };
      syntaxes = {};
      themes = {
        catppuccin = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "main";
            # sha256 = lib.fakeSha256;
            sha256 = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
          };
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
    };
  };
}

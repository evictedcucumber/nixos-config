{pkgs, ...}: let
  batTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "main";
    sha256 = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
  };
  yaziTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "yazi";
    rev = "main";
    sha256 = "sha256-Og33IGS9pTim6LEH33CO102wpGnPomiperFbqfgrJjw=";
  };
  yaziConfig = pkgs.fetchFromGitHub {
    owner = "sxyazi";
    repo = "yazi";
    rev = "main";
    sha256 = "sha256-aHkFb31ox27b5mGtmVW/a2fQkCY9OPOGTcs3tr1zvCs=";
  };
in {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableFishIntegration = true;
  };

  xdg.configFile = {
    "yazi/yazi.toml".source = ../../configs/yazi-config.toml;
    "yazi/theme.toml".source = "${yaziTheme}/themes/mocha/catppuccin-mocha-rosewater.toml";
    "yazi/keymap.toml".source = "${yaziConfig}/yazi-config/preset/keymap-default.toml";
    "yazi/Catppuccin-mocha.tmTheme;".source = "${batTheme}/themes/Catppuccin Mocha.tmTheme";
  };
}

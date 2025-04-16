{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {me.cli.yazi.enable = lib.mkEnableOption "Enable Yazi";};

  config = lib.mkIf config.me.cli.yazi.enable {
    home.packages = with pkgs; [
      file
      nerd-fonts.jetbrains-mono
      ffmpeg
      p7zip
      jq
      poppler
      fd
      ripgrep
      fzf
      zoxide
      resvg
      imagemagick
    ];

    programs.yazi.enable = true;
    programs.yazi.package = pkgs.yazi;
    programs.yazi.enableZshIntegration = true;
    programs.yazi.settings = {manager = {show_hidden = true;};};
    home.file.".config/yazi/theme.toml".source = builtins.fetchurl {
      url = "https://github.com/catppuccin/yazi/raw/main/themes/mocha/catppuccin-mocha-lavender.toml";
      sha256 = "0dfpm723nvsvr8q69q3mzyvz4n711z3030x5izrliff5kl1i0z6q";
    };
  };
}

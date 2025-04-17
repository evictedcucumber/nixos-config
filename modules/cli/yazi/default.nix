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
    home.file.".config/yazi/yazi.toml".source = ./yazi.toml;
    home.file.".config/yazi/theme.toml".source = ./theme.toml;
    home.file.".config/yazi/keymap.toml".source = ./keymap.toml;
  };
}

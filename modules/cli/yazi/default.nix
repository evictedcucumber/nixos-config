{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../fd.nix
    ../ripgrep.nix
    ../fzf.nix
    ../zoxide.nix
  ];

  options = {
    me.cli.yazi = {
      enable = lib.mkEnableOption "Enable Yazi";
      enableFish = lib.mkEnableOption "Enable Yazi Fish Integration";
    };
  };

  config = lib.mkIf config.me.cli.yazi.enable {
    me.cli.fd.enable = true;
    me.cli.ripgrep.enable = true;
    me.cli.fzf.enable = true;
    me.cli.zoxide.enable = true;

    home.packages = with pkgs; [
      file
      nerd-fonts.jetbrains-mono
      ffmpeg
      p7zip
      jq
      poppler
      resvg
      imagemagick
    ];

    programs.yazi = {
      enable = true;
      package = pkgs.yazi;
      enableFishIntegration = config.me.cli.yazi.enableFish;
    };

    home.file."${config.xdg.configHome}/yazi/yazi.toml".source = ./yazi.toml;
    home.file."${config.xdg.configHome}/yazi/theme.toml".source = ./theme.toml;
    home.file."${config.xdg.configHome}/yazi/keymap.toml".source = ./keymap.toml;
    home.file."${config.xdg.configHome}/yazi/Catppuccin-mocha.tmTheme;".source = ./Catppuccin-mocha.tmTheme;
  };
}

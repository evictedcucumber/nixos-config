{
  lib,
  config,
  pkgs,
  ...
}: let
  mkSymlink = link: (import ../../../utilities/mkSymlink.nix) link config;
in {
  options.me.files.yazi.enable = lib.mkEnableOption "Enable Yazi Files";

  config = lib.mkIf config.me.files.yazi.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = config.me.shells.fish.integrations.enable;
      settings.mgr.show_hidden = true;
    };

    home.packages = with pkgs; [
      ffmpeg
      file
      imagemagick
      p7zip
      poppler
      resvg
    ];

    xdg.configFile."yazi/flavors".source = mkSymlink "files/yazi/flavors";
    xdg.configFile."yazi/theme.toml".source = mkSymlink "files/yazi/theme.toml";
  };
}

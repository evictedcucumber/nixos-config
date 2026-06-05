{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.files.yazi.enable = lib.mkEnableOption "Enable Yazi Files";

  config = lib.mkIf config.me.files.yazi.enable {
    programs.yazi = {
      enable = true;
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

    xdg.configFile."yazi/flavors".source = ../../../config/files/yazi/flavors;
    xdg.configFile."yazi/theme.toml".source = ../../../config/files/yazi/theme.toml;
  };
}

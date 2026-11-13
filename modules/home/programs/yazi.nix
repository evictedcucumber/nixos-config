{
  config,
  pkgs,
  ...
}: let
  mkSymlink = link: (import ../../../lib/mkSymlink.nix) link config;
in {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
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
}

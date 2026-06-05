{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.media.spotify.enable = lib.mkEnableOption "Enable Spotify";

  config = lib.mkIf config.me.media.spotify.enable {
    home.packages = [pkgs.spotify];
  };
}

{
  lib,
  config,
  ...
}: {
  options.me.media.mpv.enable = lib.mkEnableOption "Enable MPV";

  config = lib.mkIf config.me.media.mpv.enable {
    programs.mpv.enable = true;
  };
}

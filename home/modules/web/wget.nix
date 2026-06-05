{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.web.wget.enable = lib.mkEnableOption "Enable WGet";

  config = lib.mkIf config.me.web.wget.enable {
    home.packages = with pkgs; [wget wget2];
  };
}

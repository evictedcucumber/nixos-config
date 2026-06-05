{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.web.curl.enable = lib.mkEnableOption "Enable Curl";

  config = lib.mkIf config.me.web.curl.enable {
    home.packages = with pkgs; [curlFull];
  };
}

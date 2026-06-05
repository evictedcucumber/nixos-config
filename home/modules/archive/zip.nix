{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.archive.zip.enable = lib.mkEnableOption "Enable Zip Archiving";

  config = lib.mkIf config.me.archive.zip.enable {
    home.packages = with pkgs; [zip unzip];
  };
}

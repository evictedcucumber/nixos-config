{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.files.nautilus.enable = lib.mkEnableOption "Enable Nautlius Files";

  config = lib.mkIf config.me.files.nautilus.enable {
    home.packages = [pkgs.nautilus];
  };
}

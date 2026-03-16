{
  pkgs,
  lib,
  config,
  ...
}: {
  options.me.system.core.boot.enable = lib.mkEnableOption "Enable Boot Options";

  config = lib.mkIf config.me.system.core.boot.enable {
    boot.kernelPackages = pkgs.linuxPackages_6_18;
  };
}

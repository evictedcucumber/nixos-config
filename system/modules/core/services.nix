{
  pkgs,
  lib,
  config,
  ...
}: {
  options.me.system.core.services.enable = lib.mkEnableOption "Enable Service Options";

  config = lib.mkIf config.me.system.core.services.enable {
    services = {
      xserver = {
        enable = true;
        excludePackages = [pkgs.xterm];
        xkb = {
          layout = "za";
          variant = "";
        };
      };
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
        jack.enable = true;
      };
      printing.enable = true;
      upower.enable = true;
      power-profiles-daemon.enable = true;
      fwupd.enable = true;
    };
  };
}

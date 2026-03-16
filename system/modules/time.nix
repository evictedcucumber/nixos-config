{
  lib,
  config,
  ...
}: {
  options.me.system.core.time.enable = lib.mkEnableOption "Enable Time Options";

  config = lib.mkIf config.me.system.core.time.enable {
    time.timeZone = "Africa/Johannesburg";
  };
}

{
  lib,
  config,
  ...
}: {
  options.me.system.core.security.enable = lib.mkEnableOption "Enable Security Options";

  config = lib.mkIf config.me.system.core.security.enable {
    security = {
      sudo.enable = true;
      rtkit.enable = true;
    };
  };
}

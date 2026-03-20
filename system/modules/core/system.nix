{
  stateVersion,
  lib,
  config,
  ...
}: {
  options.me.system.core.system.enable = lib.mkEnableOption "Enable System Options";

  config = lib.mkIf config.me.system.core.system.enable {
    system.stateVersion = stateVersion;
  };
}

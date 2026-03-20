{
  lib,
  config,
  ...
}: {
  options.me.system.core.networking.hostName = lib.mkOption {
    type = lib.types.str;
    description = "System hostname";
  };

  config = {
    networking.hostName = config.me.system.core.networking.hostName;
  };
}

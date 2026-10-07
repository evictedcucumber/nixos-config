{
  lib,
  config,
  ...
}: {
  options.me.tools.nh = {
    enable = lib.mkEnableOption "Enable NH";
    flake = lib.mkOption {
      type = lib.types.str;
      default = "INVALID_MUST_REPLACE";
      description = "Set NH Flake Path";
    };
  };

  config = lib.mkIf config.me.tools.nh.enable {
    programs.nh = {
      enable = true;
      flake = config.me.tools.nh.flake;
    };
  };
}

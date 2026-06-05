{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.tools.make.enable = lib.mkEnableOption "Enable Make";

  config = lib.mkIf config.me.tools.make.enable {
    home.packages = with pkgs; [gnumake];
  };
}

{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.tools.lefthook.enable = lib.mkEnableOption "Enable Lefthook";

  config = lib.mkIf config.me.tools.lefthook.enable {
    home.packages = [pkgs.lefthook];
  };
}

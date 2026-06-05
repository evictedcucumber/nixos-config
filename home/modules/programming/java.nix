{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.programming.java.enable = lib.mkEnableOption "Enable Java";

  config = lib.mkIf config.me.programming.java.enable {
    programs.java = {
      enable = true;
      package = pkgs.jdk25;
    };
  };
}

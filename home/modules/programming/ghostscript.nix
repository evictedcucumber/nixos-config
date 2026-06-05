{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.programming.ghostscript.enable = lib.mkEnableOption "Enable Ghostscript Compiler";

  config = lib.mkIf config.me.programming.ghostscript.enable {
    home.packages = with pkgs; [ghostscript];
  };
}

{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.programming.python.enable = lib.mkEnableOption "Enable Python Compiler";

  config = lib.mkIf config.me.programming.python.enable {
    home.packages = with pkgs; [
      python3
      python3Packages.pip
      python3Packages.virtualenv
    ];
  };
}

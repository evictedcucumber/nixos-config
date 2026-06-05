{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.tools.bat.enable = lib.mkEnableOption "Enable Bat";

  config = lib.mkIf config.me.tools.bat.enable {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batgrep
        batman
        batpipe
        batwatch
      ];
    };
  };
}

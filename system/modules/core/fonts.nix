{
  pkgs,
  lib,
  config,
  ...
}: {
  options.me.system.core.fonts.enable = lib.mkEnableOption "Enable Font Options";

  config = lib.mkIf config.me.system.core.fonts.enable {
    fonts.packages = with pkgs; [
      inter
      nerd-fonts.jetbrains-mono
    ];
  };
}

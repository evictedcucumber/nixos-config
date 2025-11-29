{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    me.gui.ghostty.enable = lib.mkEnableOption "Enable Ghostty";
    me.gui.ghostty.enableFish = lib.mkEnableOption "Enable Fish";
  };

  config = lib.mkIf config.me.gui.ghostty.enable {
    home.packages = [pkgs.nerd-fonts.jetbrains-mono];
    programs.ghostty = {
      enable = true;
      enableFishIntegration = config.me.gui.ghostty.enableFish;
    };
  };
}

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
      settings = {
        theme = "Catppuccin Mocha";
        font-family = "JetBrainsMono Nerd Font";
        cursor-style-blink = false;
        maximize = true;
        window-decoration = "none";
        window-padding-x = 4;
        window-padding-y = 2;
      };
    };
  };
}

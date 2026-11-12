{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.terminals.ghostty.enable = lib.mkEnableOption "Enable Ghostty Terminal";

  config = lib.mkIf config.me.terminals.ghostty.enable {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = config.me.shells.fish.integrations.enable;
      package = inputs.ghostty-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
      settings = {
        theme = "Rose Pine";
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

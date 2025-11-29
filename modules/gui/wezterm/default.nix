{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {me.gui.wezterm.enable = lib.mkEnableOption "Enable Wezterm";};

  config = lib.mkIf config.me.gui.wezterm.enable {
    home.packages = [pkgs.nerd-fonts.jetbrains-mono];
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./config.lua;
    };
  };
}

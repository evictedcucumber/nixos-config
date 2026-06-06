{
  lib,
  config,
  pkgs,
  ...
}: let
  mkSymlink = link: (import ../../../utilities/mkSymlink.nix) link config;
in {
  options.me.wms.hyprland.enable = lib.mkEnableOption "Enable Hyprland WM";

  config = lib.mkIf config.me.wms.hyprland.enable {
    home.packages = with pkgs; [hyprtoolkit rose-pine-hyprcursor];

    home.pointerCursor = {hyprcursor.enable = true;};

    xdg.configFile."hypr".source = mkSymlink "wms/hyprland";
  };
}

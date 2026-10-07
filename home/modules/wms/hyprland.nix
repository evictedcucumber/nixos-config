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
    home.packages = [pkgs.rose-pine-hyprcursor];

    # XCursor theme comes from home.pointerCursor; hyprcursor uses its own theme.
    home.sessionVariables = {
      HYPRCURSOR_THEME = "rose-pine-hyprcursor";
      HYPRCURSOR_SIZE = config.home.pointerCursor.size;
    };

    # UWSM doesn't read hm-session-vars on its own; export them into the
    # graphical session so systemd services and launched apps see them.
    xdg.configFile."uwsm/env".text = ''
      . "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh"
    '';

    xdg.configFile."hypr".source = mkSymlink "wms/hyprland";
  };
}

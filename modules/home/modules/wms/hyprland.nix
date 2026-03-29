{self, ...}: let
  ipc = "noctalia-shell ipc call";
in {
  flake.homeModules.hyprland = {pkgs, ...}: {
    imports = [self.homeModules.nautilus];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      settings = {
        monitor = [",1920x1080,auto,1.25"];
        exec-once = ["noctalia-shell"];
        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
          "HYPRCURSOR_THEME,catppuccin-mocha-dark-cursors"
        ];
        general = {
          gaps_in = 3;
          gaps_out = 5;
          border_size = 2;
          resize_on_border = false;
          allow_tearing = true;
          layout = "dwindle";
        };
        decoration = {
          rounding = 10;
          rounding_power = 2;
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = true;
            size = 3;
            passes = 2;
            vibrancy = 0.1696;
          };
        };
        animations.enabled = "yes, please :)";
        dwindle = {
          pseudotile = true;
          force_split = 2;
        };
        master.new_status = "master";
        misc = {
          force_default_wallpaper = 1;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          vfr = true;
        };
        input = {
          kb_layout = "za";
          numlock_by_default = true;
          touchpad.natural_scroll = true;
        };
        gesture = ["3, horizontal, workspace"];
        layerrule = [
          {
            name = "noctalia";
            "match:namespace" = "noctalia-background-.*$";
            ignore_alpha = 0.5;
            blur = true;
            blur_popups = true;
          }
        ];
        windowrule = [
          {
            name = "suppress-maximize-events";
            "match:class" = ".*";
            suppress_event = "maximize";
          }
          {
            name = "fix-xwayland-drags";
            "match:class" = "^$";
            "match:title" = "^$";
            "match:xwayland" = true;
            "match:float" = true;
            "match:fullscreen" = false;
            "match:pin" = false;
            no_focus = true;
          }
        ];
        bind = [
          # Main
          "SUPER, T, exec, ghostty"
          "SUPER, W, killactive,"
          "SUPER, E, exec, nautilus"
          "SUPER, V, togglefloating,"
          "SUPER, B, exec, helium"

          # Window Focus
          "SUPER SHIFT, H, movefocus, l"
          "SUPER SHIFT, L, movefocus, r"
          "SUPER SHIFT, K, movefocus, u"
          "SUPER SHIFT, J, movefocus, d"

          # Workspaces
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"

          "SUPER, S, togglespecialworkspace, magic"
          "SUPER SHIFT, S, movetoworkspace, special:magic"

          "SUPER, SPACE, exec, ${ipc} launcher toggle"
          "SUPER, comma, exec, ${ipc} settings toggle"
          "SUPER, L, exec, ${ipc} lockScreen lock"
          "CTRL + SHIFT, ESCAPE, exec, ${ipc} systemMonitor toggle"
        ];
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
        bindl = [
          ", XF86AudioMute, exec, ${ipc} volume muteOutput"
          ", XF86AudioNext, exec, ${ipc} media next"
          ", XF86AudioPause, exec, ${ipc} media pause"
        ];
        bindel = [
          ", XF86AudioRaiseVolume, exec, ${ipc} volume increase"
          ", XF86AudioLowerVolume, exec, ${ipc} volume decrease"
          ", XF86MonBrightnessUp, exec, ${ipc} brightness increase"
          ", XF86MonBrightnessDown, exec, ${ipc} brightness decrease"
          ", XF86AudioPlay, exec, ${ipc} media play"
          ", XF86AudioPrev, exec, ${ipc} media previous"
        ];
      };
    };

    home.packages = with pkgs; [
      hyprtoolkit
      catppuccin-cursors.mochaDark
    ];

    home.pointerCursor = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
      hyprcursor.enable = true;
    };
  };
}

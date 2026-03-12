{...}: {
  programs.noctalia-shell = {
    enable = true;
    settings = {
      general = {
        clockStyle = "digital";
        lockScreenAnimations = true;
        scaleRatio = 0.9;
        showHibernateOnLockScreen = true;
      };
      bar = {
        barType = "floating";
        density = "compact";
        floating = true;
        widgets = {
          left = [
            {
              id = "Workspace";
              labelMode = "name";
            }
            {id = "ActiveWindow";}
          ];
          center = [
            {id = "Clock";}
            {
              id = "NotificationHistory";
              hideWhenZero = true;
            }
          ];
          right = [
            {id = "Tray";}
            {
              id = "Battery";
              displayMode = "graphic";
            }
            {id = "Volume";}
            {id = "Brightness";}
            {
              id = "ControlCenter";
              colorizeDistroLogo = true;
              useDistroLogo = true;
            }
            {id = "plugin:privacy-indicator";}
          ];
        };
      };
      appLauncher = {
        density = "compact";
        overviewLayer = true;
        terminalCommand = "ghostty -e";
      };
      controlCenter = {
        shortcuts = {
          left = [
            {id = "Network";}
            {id = "Bluetooth";}
            {id = "NoctaliaPerformance";}
          ];
          right = [
            {id = "Notifications";}
            {id = "PowerProfile";}
            {id = "KeepAwake";}
          ];
        };
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = true;
            id = "brightness-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };
      dock = {enabled = false;};
      sessionMenu = {
        largeButtonsLayout = "gird";
        enableCountdown = false;
        powerOptions = [
          {
            action = "lock";
            enabled = true;
            keybind = "1";
          }
          {
            action = "suspend";
            enabled = true;
            keybind = "2";
          }
          {
            action = "hibernate";
            enabled = true;
            keybind = "3";
          }
          {
            action = "reboot";
            enabled = true;
            keybind = "4";
          }
          {
            action = "logout";
            enabled = true;
            keybind = "5";
          }
          {
            action = "shutdown";
            enabled = true;
            keybind = "6";
          }
        ];
      };
      notifications = {
        density = "compact";
        sounds = {
          enabled = true;
          separateSounds = true;
        };
        enableMediaToast = true;
      };
      osd = {
        enabledTypes = [
          0
          1
          2
          3
        ];
      };
      colorSchemes = {predefinedScheme = "Catppuccin";};
      templates = {
        activeTemplates = [
          {
            enabled = true;
            id = "hyprland";
          }
          {
            enabled = true;
            id = "yazi";
          }
          {
            enabled = true;
            id = "gtk";
          }
          {
            enabled = true;
            id = "qt";
          }
          {
            enabled = true;
            id = "kcolorscheme";
          }
          {
            enabled = true;
            id = "ghostty";
          }
        ];
      };
      plugins = {autoUpdate = true;};
      idle = {
        enabled = true;
        screenOffTimeout = 300;
        lockTimeout = 330;
        suspendTimeout = 360;
      };
      location = {
        firstDayOfWeek = 0;
        hideWeatherCityName = true;
        hideWeatherTimezone = true;
        name = "Johannesburg";
      };
      ui = {
        fontDefault = "Inter";
        fontFixed = "JetBrainsMono NF";
      };
      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
        ];
      };
    };
  };
}

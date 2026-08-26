{
  config,
  pkgs,
  ...
}: {
  imports = [./default.nix];

  # :: ME {
  # Delta on top of the common profile in ./default.nix.
  me = {
    browsers = {
      brave.enable = true;
      helium.enable = true;
    };
    editors.vscode.enable = true;
    files.nautilus.enable = true;
    # games.modrinth.enable = true;
    media = {
      flameshot.enable = true;
      mpv.enable = true;
      spotify.enable = true;
    };
    notes.obsidian.enable = true;
    terminals.ghostty.enable = true;
    tools = {
      git.settings.signingKey = "CB029F0E386B37C7";
      hledger = {
        enable = true;
        ledgersDir = "${config.home.homeDirectory}/Documents/My Obsidian Vault/97 - Finance";
      };
    };
    wms = {
      hyprland.enable = true;
      noctalia.enable = true;
    };
  };
  # :: }

  # :: GTK {
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "rose-pine";
      package = pkgs.rose-pine-icon-theme;
    };
    cursorTheme = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 24;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
  # :: }

  # :: DCONF {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "rose-pine";
      cursor-theme = "BreezeX-RosePine-Linux";
      cursor-size = 24;
    };
  };
  # :: }

  # :: QT {
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
  # :: }

  # :: HOME {
  home = {
    sessionVariables = {
      GTK_THEME = "adw-gtk3-dark";
    };
    pointerCursor = {
      enable = true;
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 24;
      gtk.enable = true;
    };
  };
  # :: }

  # :: XDG {
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };
  # :: }
}

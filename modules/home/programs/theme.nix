# GTK, Qt and cursor theming.
{pkgs, ...}: let
  cursor = {
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 24;
  };
in {
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
      cursor-theme = cursor.name;
      cursor-size = cursor.size;
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
    pointerCursor =
      cursor
      // {
        enable = true;
        gtk.enable = true;
      };
  };
  # :: }
}

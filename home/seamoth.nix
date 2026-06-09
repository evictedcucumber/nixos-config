{
  config,
  pkgs,
  ...
}: {
  imports = [./default.nix];

  # :: ME {
  me = {
    archive.zip.enable = true;
    browsers = {
      brave.enable = true;
      helium.enable = true;
    };
    databases.sqlite.enable = true;
    editors = {
      antigravity.enable = true;
      cursor.enable = true;
      neovim.enable = true;
      vscode.enable = true;
      windsurf.enable = true;
      zed.enable = true;
    };
    files = {
      nautilus.enable = true;
      yazi.enable = true;
    };
    games.modrinth.enable = true;
    media = {
      flameshot.enable = true;
      mpv.enable = true;
      spotify.enable = true;
    };
    multiplexers.tmux.enable = true;
    navigation = {
      fzf.enable = true;
      tv.enable = true;
      zoxide.enable = true;
    };
    notes.obsidian.enable = true;
    programming = {
      gcc.enable = true;
      ghostscript.enable = true;
      java.enable = true;
      javascript.enable = true;
      latex.enable = true;
      lua.enable = true;
      mermaid.enable = true;
      python.enable = true;
      rust.enable = true;
      treesitter.enable = true;
    };
    searchers = {
      fd.enable = true;
      jq.enable = true;
      ripgrep.enable = true;
    };
    shells.fish = {
      enable = true;
      integrations.enable = true;
    };
    terminals.ghostty.enable = true;
    tools = {
      bat.enable = true;
      direnv.enable = true;
      eza.enable = true;
      git = {
        enable = true;
        settings.signingKey = "CB029F0E386B37C7";
      };
      hledger = {
        enable = true;
        ledgersDir = "${config.home.homeDirectory}/Documents/My Obsidian Vault/97 - Finance";
      };
      lazygit.enable = true;
      make.enable = true;
      nh = {
        enable = true;
        flake = "${config.home.homeDirectory}/repos/nixos-config";
      };
      ssh = {
        enable = true;
        hasGithubKey = true;
      };
      tealdeer.enable = true;
    };
    utilities = {
      fastfetch.enable = true;
      nix-your-shell.enable = true;
      starship.enable = true;
    };
    web = {
      curl.enable = true;
      wget.enable = true;
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
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
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
      gtk-theme = "rose-pine";
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
      GTK_THEME = "rose-pine";
    };
    pointerCursor = {
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

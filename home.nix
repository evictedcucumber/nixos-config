{
  config,
  pkgs,
  stateVersion,
  zen-browser,
  helium-browser,
  neovim-config,
  ...
}: let
  bat_theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "main";
    sha256 = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
  };
  bottom_theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bottom";
    rev = "main";
    sha256 = "sha256-dfukdk70ug1lRGADKBnvMhkl+3tsY7F+UAwTS2Qyapk=";
  };
  yazi_theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "yazi";
    rev = "main";
    sha256 = "sha256-Og33IGS9pTim6LEH33CO102wpGnPomiperFbqfgrJjw=";
  };
  yazi_config = pkgs.fetchFromGitHub {
    owner = "sxyazi";
    repo = "yazi";
    rev = "main";
    sha256 = "sha256-xOltBlD5nU8kMzh7GPoTtkDD8sEDAzTtaR3LRPDWRS0=";
  };
  fish_theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "main";
    sha256 = "sha256-KD/sWXSXYVlV+n7ft4vKFYpIMBB3PSn6a6jz+ZIMZvQ=";
  };
in {
  home = {
    username = "ethan";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = stateVersion;
    sessionVariables = {
      FZF_DEFAULT_OPTS = ''
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
        --color=selected-bg:#45475a
        --color=border:#313244,label:#cdd6f4
      '';
      BAT_THEME = "catppuccin";
      EDITOR = "nvim";
    };
    sessionPath = [
      "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
    ];
    packages = with pkgs;
      [
        brave
        ffmpeg
        file
        imagemagick
        jq
        nerd-fonts.jetbrains-mono
        obsidian
        p7zip
        poppler
        resvg
        zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

        ## NEOVIM
        gcc
        gnumake
        lua51Packages.sqlite
        lua5_1
        luarocks
        neovim
        nodejs
        nodejs
        python3
        python3Packages.pip
        python3Packages.pylatexenc
        python3Packages.virtualenv
        sqlite
        tree-sitter
        unzip
        wget
        yarn

        # LSP Servers, Formatters, and Debuggers
        # lua
        lua-language-server
        stylua
        # /lua
        # nix
        nixd
        alejandra
        # /nix
        # markdown
        marksman
        prettierd
        # /markdown
        # rust
        (rust-bin.stable.latest.default.override {
          extensions = ["rust-analyzer"];
        })
        vscode-extensions.vadimcn.vscode-lldb
        # /rust
        # # makefile
        autotools-language-server
        mbake
        # # /makefile
        # toml
        taplo
        # /toml
        # harper
        harper
        # /harper
        ## /NEOVIM
      ]
      ++ (with pkgs.bat-extras; [
        batdiff
        batdiff
        batgrep
        batman
        batpipe
        batwatch
      ]);
  };

  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.local/cache";
    configFile = {
      "bottom/bottom.toml".source = "${bottom_theme}/themes/mocha.toml";
      "zellij/config.kdl".source = ./configs/zellij-config.kdl;
      "zellij/layouts/default.kdl".source = ./configs/zellij-layout.kdl;
      "yazi/yazi.toml".source = ./configs/yazi-config.toml;
      "yazi/theme.toml".source = "${yazi_theme}/themes/mocha/catppuccin-mocha-rosewater.toml";
      "yazi/keymap.toml".source = "${yazi_config}/yazi-config/preset/keymap-default.toml";
      "yazi/Catppuccin-mocha.tmTheme;".source = "${bat_theme}/themes/Catppuccin Mocha.tmTheme";
      "fish/themes/Catppuccin Mocha.theme".source = "${fish_theme}/themes/Catppuccin Mocha.theme";
      "nvim/init.lua".source = "${neovim-config}/init.lua";
      "nvim/lua".source = "${neovim-config}/lua";
    };
  };

  programs.home-manager.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;
  programs.fd.enable = true;
  programs.fastfetch.enable = true;
  programs.eza.enable = true;
  programs.bottom.enable = true;
  programs.zellij.enable = true;

  programs.tealdeer = {
    enable = true;
    settings = {
      display.use_pager = true;
      directories.cache_dir = "${config.xdg.cacheHome}/tealdeer";
      updates.auto_update = true;
    };
  };
  programs.ripgrep = {
    enable = true;
    arguments = ["--color=always"];
  };
  programs.nix-your-shell = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };
  programs.bat = {
    enable = true;
    config.theme = "catppuccin";
    syntaxes = {};
    themes.catppuccin = {
      src = bat_theme;
      file = "themes/Catppuccin Mocha.tmTheme";
    };
  };
  programs.lazygit = {
    enable = true;
    settings.gui.theme = {
      activeBorderColor = ["#89b4fa" "bold"];
      inactiveBorderColor = ["#a6adc8"];
      optionsTextColor = ["#89b4fa"];
      selectedLineBgColor = ["#313244"];
      cherryPickedCommitBgColor = ["#45475a"];
      cherryPickedCommitFgColor = ["#89b4fa"];
      unstagedChangesColor = ["#f38ba8"];
      defaultFgColor = ["#cdd6f4"];
      searchingActiveBorderColor = ["#f9e2af"];
    };
  };
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableFishIntegration = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ethan";
        email = "95688781+evictedcucumber@users.noreply.github.com";
        signingkey = "9ECE1D3B3AAE0D67";
      };
      init.defaultbranch = "main";
      pull.rebase = true;
      rebase.updaterefs = true;
      commit.gpgsign = true;
      tag.gpgSign = true;
    };
  };
  programs.fish = {
    enable = true;
    loginShellInit = "fastfetch";
    shellInit = "set -u fish_greeting \"\"";
    shellInitLast = ''
      status is-interactive; and begin
        enable_transience
      end
    '';
    shellAbbrs = {
      v = "NVIM_APPNAME=neovim nvim";
      cat = "bat";
      mkdir = "mkdir -p";
      grep = "rg";
      ls = "eza -a -F=always --icons always --group-directories-first --sort=name -1 --colour always";
      la = "eza -a -F=always --icons always --group-directories-first --sort=name -1 --colour always --git -l -h --no-time --group";
      lt = "eza -a -F=always --icons always --group-directories-first --sort=name -1 --colour always -T -I='.git'";
      "z-" = "z -";
      "z.." = "z ..";
    };
    interactiveShellInit = ''
      bind \cf yy
      bind \cj down-or-search
      bind \ck up-or-search
    '';
  };
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      palette = "catppuccin_mocha";
      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
      format = ''
        $directory$git_branch$git_status$rust
        $nix_shell$cmd_duration$character
      '';
      directory = {
        truncation_length = 3;
        read_only = "  ";
        fish_style_pwd_dir_length = 1;
      };
      cmd_duration.min_time = 5000;
      nix_shell.format = "via [$symbol$name]($style) ";
    };
  };
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
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
}

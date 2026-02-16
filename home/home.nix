{
  config,
  pkgs,
  stateVersion,
  neovim-config,
  helium-browser,
  ...
}: let
  bottomTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bottom";
    rev = "main";
    sha256 = "sha256-dfukdk70ug1lRGADKBnvMhkl+3tsY7F+UAwTS2Qyapk=";
  };
  yaziTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "yazi";
    rev = "main";
    sha256 = "sha256-Og33IGS9pTim6LEH33CO102wpGnPomiperFbqfgrJjw=";
  };
  yaziConfig = pkgs.fetchFromGitHub {
    owner = "sxyazi";
    repo = "yazi";
    rev = "main";
    sha256 = "sha256-aHkFb31ox27b5mGtmVW/a2fQkCY9OPOGTcs3tr1zvCs=";
  };
  fishTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "main";
    sha256 = "sha256-5CXdzym6Vp+FbKTVBtVdWoh3dODudADIzOLXIyIIxgQ=";
  };
  batTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "main";
    sha256 = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
  };
in {
  imports = [./modules/cli ./modules/tui ./modules/gui];

  me.cli.git.signingkey = "A2FD5AF74494FD44";

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
        ffmpeg
        file
        imagemagick
        jq
        p7zip
        poppler
        resvg

        ## GUI
        brave
        obsidian
        helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ## /GUI

        ## FONTS
        inter
        nerd-fonts.jetbrains-mono
        ## /FONTS

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
        ghostscript
        tectonic
        texliveSmall
        mermaid-cli

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
      "bottom/bottom.toml".source = "${bottomTheme}/themes/mocha.toml";
      "zellij/config.kdl".source = ./configs/zellij-config.kdl;
      "zellij/layouts/default.kdl".source = ./configs/zellij-layout.kdl;
      "yazi/yazi.toml".source = ./configs/yazi-config.toml;
      "yazi/theme.toml".source = "${yaziTheme}/themes/mocha/catppuccin-mocha-rosewater.toml";
      "yazi/keymap.toml".source = "${yaziConfig}/yazi-config/preset/keymap-default.toml";
      "yazi/Catppuccin-mocha.tmTheme;".source = "${batTheme}/themes/Catppuccin Mocha.tmTheme";
      "fish/themes/Catppuccin Mocha.theme".source = "${fishTheme}/themes/Catppuccin Mocha.theme";
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
}

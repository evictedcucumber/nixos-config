{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.neovimConfigPath = lib.mkOption {
    type = lib.types.str;
    default = "${config.home.homeDirectory}/repos/neovim-config";
    description = "Where the Neovim config repo is cloned.";
  };

  config = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    # Config lives in ~/.config/neovim; make $EDITOR use it too.
    home.sessionVariables.NVIM_APPNAME = "neovim";
    xdg.configFile."neovim".source = config.lib.file.mkOutOfStoreSymlink config.me.neovimConfigPath;
    home.activation.mePathCheckNeovim = import ../../../lib/mkPathCheck.nix {inherit lib config;} {
      option = "me.neovimConfigPath";
      path = config.me.neovimConfigPath;
    };

    # The config also needs rg and fd (cli profile) and tree-sitter, a C
    # compiler and rustfmt/rust-analyzer (dev profile).
    home.packages = with pkgs; [
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
      vscode-extensions.vadimcn.vscode-lldb
      # /rust
      # # makefile
      autotools-language-server
      mbake
      # # /makefile
      # toml
      taplo
      # /toml
      # hyprland
      hyprls
      # /hyprland
      # yaml
      yamlfix
      yaml-language-server
      # /yaml
      # powershell
      powershell
      powershell-editor-services
      # /powershell
      # python
      pyright
      ruff
      # /python
      # markdown rendering (render-markdown.nvim)
      python3Packages.pylatexenc # latex2text, for latex-in-markdown rendering
      # /markdown rendering
      # file explorer (snacks.nvim)
      trash-cli # system trash for explorer deletes
      # /file explorer
      # ansible
      ansible-lint
      ansible-language-server
      # /ansible
      # bash
      bash-language-server
      # /bash
      # latex
      texlab
      # /latex
    ];

    home.sessionPath = [
      "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
    ];
  };
}

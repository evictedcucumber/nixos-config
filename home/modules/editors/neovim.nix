{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.editors.neovim.enable = lib.mkEnableOption "Enable Neovim Editor";

  config = lib.mkIf config.me.editors.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    # Config lives in ~/.config/neovim; make $EDITOR use it too.
    home.sessionVariables.NVIM_APPNAME = "neovim";

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
    ];

    home.sessionPath = [
      "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
    ];
  };
}

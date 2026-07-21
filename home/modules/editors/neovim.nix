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
      package = pkgs.neovim;
    };

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
      # harper
      harper
      # /harper
      # go
      gopls
      # /go
      # hyprland
      hyprls
      # /hyprland
      # yaml
      yamlfix
      yaml-language-server
      # /yaml
    ];

    home.sessionPath = [
      "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
    ];
  };
}

{
  lib,
  config,
  pkgs,
  neovim-config,
  ...
}: {
  options = {me.cli.neovim.enable = lib.mkEnableOption "Enable Neovim";};

  config = lib.mkIf config.me.cli.neovim.enable {
    home.packages = with pkgs; [
      gnumake
      gcc
      luarocks
      python3
      python3Packages.pip
      python3Packages.virtualenv
      python3Packages.pylatexenc
      lua5_1
      lua51Packages.sqlite
      unzip
      wget
      nodejs
      sqlite
      tree-sitter
      neovim
      nodejs
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
      # autotools-language-server
      # # /makefile
      # toml
      taplo
      # /toml
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };
    home.sessionPath = [
      "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
    ];

    home.file = {
      ".config/nvim/init.lua".source = "${neovim-config}/init.lua";
      ".config/nvim/lua".source = "${neovim-config}/lua";
    };
  };
}

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
      lua5_1
      lua51Packages.sqlite
      unzip
      wget
      nodejs
      sqlite
      tree-sitter
      neovim
      rust-bin.stable.latest.minimal

      #LSP servers
      lua-language-server
      alejandra
      nixd
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.file = {
      ".config/nvim/init.lua".source = "${neovim-config}/init.lua";
      ".config/nvim/lua".source = "${neovim-config}/lua";
    };
  };
}

{
  pkgs,
  neovim-config,
  ...
}: {
  home.packages = with pkgs; [
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
  ];

  xdg.configFile = {
    "nvim/init.lua".source = "${neovim-config}/init.lua";
    "nvim/lua".source = "${neovim-config}/lua";
  };
}

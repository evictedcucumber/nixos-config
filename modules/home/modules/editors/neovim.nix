{...}: {
  flake.homeModules.neovim = {pkgs, ...}: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      package = pkgs.neovim;
    };

    home.packages = with pkgs; [
      gcc
      ghostscript
      gnumake
      lua51Packages.sqlite
      lua5_1
      luarocks
      mermaid-cli
      python3
      python3Packages.pip
      python3Packages.pylatexenc
      python3Packages.virtualenv
      sqlite
      tectonic
      texliveSmall
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
      # go
      gopls
      # /go
      # hyprland
      hyprls
      # /hyprland
    ];

    home.sessionPath = [
      "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
    ];
  };
}

# Editor, compilers and language toolchains.
{pkgs, ...}: {
  imports = [
    ./cli.nix
    ../programs/javascript.nix
    ../programs/neovim.nix
  ];

  home.packages = with pkgs; [
    ghostscript
    gnumake
    lefthook
    luajit
    luarocks
    mermaid-cli
    python3
    python3Packages.pip
    python3Packages.virtualenv
    (rust-bin.stable.latest.default.override {
      extensions = ["rust-analyzer"];
    })
    tectonic
    tree-sitter
  ];

  programs = {
    gcc.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk25;
    };
    texlive.enable = true;
  };
}

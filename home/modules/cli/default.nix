{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./nix-your-shell.nix
    ./ripgrep.nix
    ./starship.nix
    ./tealdeer.nix
  ];

  home.packages = with pkgs; [
    javaPackages.compiler.openjdk21
  ];
}

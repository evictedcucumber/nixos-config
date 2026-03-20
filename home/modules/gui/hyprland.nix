{pkgs, ...}: {
  imports = [./noctalia.nix];

  home.packages = with pkgs; [
    hyprtoolkit
    nautilus
    catppuccin-cursors.mochaDark
  ];

  home.pointerCursor = {
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 24;
    hyprcursor.enable = true;
  };
}

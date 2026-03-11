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

  xdg.configFile = {
    "hypr/hyprland.conf".source = ../../../config/hypr/hyprland.conf;
    "hypr/windowrules.conf".source = ../../../config/hypr/windowrules.conf;
    "hypr/bindings.conf".source = ../../../config/hypr/bindings.conf;
  };
}

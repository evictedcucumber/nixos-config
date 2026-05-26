{self, ...}: {
  flake.homeModules.hyprland = {pkgs, ...}: {
    imports = [self.homeModules.nautilus];

    home.packages = with pkgs; [
      hyprtoolkit
      catppuccin-cursors.mochaDark
    ];

    home.pointerCursor = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
      hyprcursor.enable = true;
    };

    xdg.configFile."hypr".source = ../../../../config/wms/hyprland;
  };
}

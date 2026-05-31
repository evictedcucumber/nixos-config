{self, ...}: {
  flake.homeModules.hyprland = {pkgs, ...}: {
    imports = [self.homeModules.nautilus];

    home.packages = with pkgs; [hyprtoolkit rose-pine-hyprcursor];

    home.pointerCursor = {hyprcursor.enable = true;};

    xdg.configFile."hypr".source = ../../../../config/wms/hyprland;
  };
}

{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    hypridle
    hyprlauncher
    hyprlock
    hyprpaper
    hyprtoolkit
    swaynotificationcenter
    waybar
  ];

  xdg.configFile."hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/nixos-config/config/hypr";
    recursive = true;
  };

  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/nixos-config/config/waybar";
    recursive = true;
  };

  xdg.configFile."swaync" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/nixos-config/config/swaync";
    recursive = true;
  };
}

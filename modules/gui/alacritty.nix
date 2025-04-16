{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    me.gui.alacritty.enable = lib.mkEnableOption "Enable Alacritty";
  };
  config = lib.mkIf config.me.gui.alacritty.enable {
    home.packages = [pkgs.nerd-fonts.jetbrains-mono];
    programs.alacritty.enable = true;
    programs.alacritty.settings = {
      general = {import = ["./catppuccin.toml"];};
      window = {
        decorations = "None";
        startup_mode = "Maximized";
        padding = {
          x = 2;
          y = 2;
        };
      };
      font = {normal = {family = "JetBrainsMono Nerd Font";};};
      cursor = {
        style = {
          shape = "Beam";
          blinking = "Never";
        };
      };
      mouse = {hide_when_typing = false;};
    };
    home.file.".config/alacritty/catppuccin.toml".source = builtins.fetchurl {
      url = "https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml";
      sha256 = "1idjbm5jim9b36235hgwgp9ab81fmbij42y7h85l4l7cqcbyz74l";
    };
  };
}

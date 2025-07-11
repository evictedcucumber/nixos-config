{
  config,
  lib,
  ...
}: {
  options = {
    me.cli.zellij.enable = lib.mkEnableOption "Enable Zellij";
  };

  config = lib.mkIf config.me.cli.zellij.enable {
    programs.zellij.enable = true;

    xdg.configFile."zellij/config.kdl".source = ./config.kdl;
    xdg.configFile."zellij/layouts/default.kdl".source = ./layouts/default.kdl;
    xdg.configFile."zellij/themes/catppuccin-mocha.kdl".source = ./themes/catppuccin-mocha.kdl;
  };
}

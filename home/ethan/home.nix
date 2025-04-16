{
  config,
  pkgs,
  ...
}: {
  home.username = "ethan";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "24.11";

  imports = [../../modules/gui ../../modules/cli];

  me.gui.enable = true;
  me.cli.enable = true;

  me.cli.shells.zsh.enable = true;

  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.local/cache";
  };

  home.packages = with pkgs; [alejandra nixd];

  home.file = {};

  home.sessionVariables = {};

  programs.home-manager.enable = true;
}

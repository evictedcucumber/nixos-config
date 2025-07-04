{config, ...}: {
  home.username = "ethan";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "25.11";

  imports = [../../modules/gui ../../modules/cli];

  me.gui.enable = true;
  me.cli.enable = true;

  me.cli.shells.zsh.enable = true;
  me.cli.git.gpgKey = "8E29907A4CA30E30";

  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.local/cache";
  };

  programs.home-manager.enable = true;
}

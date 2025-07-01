{config, ...}: {
  home.username = "ethan-vaxowave";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "25.11";

  imports = [../../modules/cli];

  me.cli.enable = true;

  me.cli.shells.zsh.enable = true;

  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.local/cache";
  };

  programs.home-manager.enable = true;
}

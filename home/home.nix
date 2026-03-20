{
  username,
  stateVersion,
  config,
  ...
}: {
  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };

  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.local/cache";
  };
}

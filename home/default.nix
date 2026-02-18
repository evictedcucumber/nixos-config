{
  config,
  stateVersion,
  username,
  ...
}: {
  imports = [./modules/cli ./modules/tui ./modules/gui];

  me.cli.git.signingkey = "A2FD5AF74494FD44";

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

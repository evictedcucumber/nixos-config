# Settings every host's home shares. Hosts pick their profiles in hosts/<host>/home.nix.
{
  config,
  osConfig,
  username,
  ...
}: {
  home = {
    inherit username;
    inherit (osConfig.system) stateVersion;
    homeDirectory = "/home/${username}";
  };

  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
  };
}

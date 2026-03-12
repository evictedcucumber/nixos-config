{
  pkgs,
  config,
  stateVersion,
  username,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    overwriteBackup = true;

    users.${username} = let
      configHome = config.home-manager.users.${username}.home.homeDirectory;
    in {
      home = {
        inherit username stateVersion;
        homeDirectory = "/home/${username}";
      };

      xdg = {
        enable = true;
        configHome = "${configHome}/.config";
        dataHome = "${configHome}/.local/share";
        stateHome = "${configHome}/.local/state";
        cacheHome = "${configHome}/.local/cache";
      };
    };
  };
}

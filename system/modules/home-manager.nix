{
  username,
  stateVersion,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    overwriteBackup = true;

    extraSpecialArgs = {inherit username stateVersion;};

    users.${username} = import ../../home/home.nix;
  };
}

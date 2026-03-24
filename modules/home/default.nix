{
  self,
  inputs,
  username,
  ...
}: {
  flake.nixosModules.sharedHomeConfiguration = {hostConfig, ...}: {
    imports = [inputs.home-manager.nixosModules.home-manager];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      overwriteBackup = true;
      extraSpecialArgs = {
        inherit inputs username;
        homeConfig = hostConfig.home;
      };
      users.${username} = self.homeModules.sharedHomeConfiguration;
    };
  };
}

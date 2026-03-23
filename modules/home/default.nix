{
  self,
  inputs,
  username,
  ...
}: {
  flake.nixosModules.sharedHomeConfiguration = {...}: {
    imports = [inputs.home-manager.nixosModules.home-manager];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      overwriteBackup = true;
      extraSpecialArgs = {inherit inputs username;};
      users.${username} = self.homeModules.sharedHomeConfiguration;
    };
  };
}

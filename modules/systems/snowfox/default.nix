{
  self,
  inputs,
  username,
  ...
}: let
  hostName = "snowfox";
in {
  flake.nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit username;
      system = "x86_64-linux";
      hostConfig = {
        inherit hostName;
      };
    };

    modules = [
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      self.nixosModules.sharedSystemConfiguration
      self.nixosModules.snowfoxConfiguration
    ];
  };
}

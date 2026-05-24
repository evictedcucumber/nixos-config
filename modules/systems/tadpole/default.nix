{
  self,
  inputs,
  username,
  ...
}: let
  hostName = "tadpole";
in {
  flake.nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit username;
      system = "x86_64-linux";
      hostConfig = {
        inherit hostName;
        home = {
          gitSigningKey = "";
          hledgerLedgersDir = "";
        };
      };
    };

    modules = [
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      self.nixosModules.tadpoleConfiguration
    ];
  };
}

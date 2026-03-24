{
  self,
  inputs,
  username,
  ...
}: let
  hostName = "seamoth";
in {
  flake.nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit username;
      system = "x86_64-linux";
      hostConfig = {
        inherit hostName;
        home = {
          gitSigningKey = "CB029F0E386B37C7";
          hledgerLedgersDir = "/home/${username}/Documents/My Obsidian Vault/97 - Finance";
        };
      };
    };

    modules = [
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      self.nixosModules.sharedSystemConfiguration
      self.nixosModules.seamothConfiguration
    ];
  };
}

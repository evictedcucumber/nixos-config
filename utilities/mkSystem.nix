{inputs}: {
  system,
  hostname,
  username,
  stateVersion,
}: let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
  inputs.nixpkgs.lib.nixosSystem {
    inherit pkgs;
    specialArgs = {inherit inputs hostname username stateVersion;};
    modules = [
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      ../systems
      ../systems/${hostname}.nix
    ];
  }

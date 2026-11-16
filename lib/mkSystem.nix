{inputs}: {
  system,
  hostname,
  username,
}: let
  inherit (inputs.nixpkgs.inputs) nixpkgs;

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = with inputs; [
      inputs.nixpkgs.overlays.default
      rust-overlay.overlays.default
      # aws-lc-sys >= 0.42 needs a system AWS-LC, which nixpkgs' tectonic doesn't provide yet.
      (final: prev: {
        tectonic-unwrapped = prev.tectonic-unwrapped.overrideAttrs (old: {
          buildInputs = old.buildInputs ++ [final.aws-lc];
        });
      })
    ];
  };
in
  nixpkgs.lib.nixosSystem {
    inherit pkgs;
    specialArgs = {inherit inputs hostname username;};
    modules = [
      nixpkgs.nixosModules.readOnlyPkgs
      ../modules/nixos
      ../hosts/${hostname}
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          overwriteBackup = true;
          extraSpecialArgs = {inherit inputs username;};
          users.${username}.imports = [../hosts/${hostname}/home.nix ../modules/home];
        };
      }
    ];
  }

{inputs}: {
  system,
  hostname,
  username,
  stateVersion,
}: let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = with inputs; [
      helium-overlay.overlays.default
      rust-overlay.overlays.default
      neovim-overlay.overlays.default
      ghostty-overlay.overlays.default
    ];
  };
in
  inputs.nixpkgs.lib.nixosSystem {
    inherit pkgs;
    specialArgs = {inherit inputs hostname username stateVersion;};
    modules = [
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      ../systems
      ../systems/${hostname}.nix
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          overwriteBackup = true;
          extraSpecialArgs = {inherit inputs username stateVersion;};
        };
      }
    ];
  }

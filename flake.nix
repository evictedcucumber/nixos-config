{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    yazi.url = "github:sxyazi/yazi";
  };

  outputs = {
    nixpkgs,
    nur,
    home-manager,
    nixos-wsl,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";

      config.allowUnfree = true;

      overlays = [
        nur.overlays.default
        inputs.rust-overlay.overlays.default
        inputs.neovim-nightly-overlay.overlays.default
        inputs.yazi.overlays.default
      ];
    };
    stateVersion = "26.05";
    username = "ethan";
    specialArgs = {inherit stateVersion username;};
  in {
    nixosConfigurations."seamoth" = nixpkgs.lib.nixosSystem {
      inherit pkgs specialArgs;

      modules = [
        nixpkgs.nixosModules.readOnlyPkgs
        home-manager.nixosModules.default
        ./system/seamoth/system.nix
      ];
    };
    nixosConfigurations."snowfox" = nixpkgs.lib.nixosSystem {
      inherit pkgs specialArgs;

      modules = [
        nixpkgs.nixosModules.readOnlyPkgs
        home-manager.nixosModules.default
        nixos-wsl.nixosModules.default
        ./system/snowfox/system.nix
      ];
    };
  };
}

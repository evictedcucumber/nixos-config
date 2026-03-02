{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium-browser = {
      url = "github:vikingnope/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    yazi.url = "github:sxyazi/yazi";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-wsl,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";

      config.allowUnfree = true;

      overlays = [
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
      inherit pkgs;

      modules = [
        nixpkgs.nixosModules.readOnlyPkgs
        home-manager.nixosModules.default
        ./system/seamoth/system.nix
      ];

      specialArgs =
        specialArgs
        // {
          helium-browser =
            inputs.helium-browser;
        };
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

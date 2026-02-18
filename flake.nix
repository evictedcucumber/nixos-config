{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay/c3e52f66f877cddce4167041546524abb76c0a70";

    neovim-config.url = "github:evictedcucumber/neovim-config/main";
    neovim-config.flake = false;

    helium-browser.url = "github:vikingnope/helium-browser-nix-flake";
    helium-browser.inputs.nixpkgs.follows = "nixpkgs";
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

      overlays = [inputs.rust-overlay.overlays.default inputs.neovim-nightly-overlay.overlays.default];
    };
    stateVersion = "26.05";
    username = "ethan";
    specialArgs = {
      inherit stateVersion username;

      neovim-config = inputs.neovim-config;
    };
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

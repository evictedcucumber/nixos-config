{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-config.url = "github:evictedcucumber/neovim-config/main";
    neovim-config.flake = false;

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    helium-browser.url = "github:vikingnope/helium-browser-nix-flake";
    helium-browser.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = {
    nixpkgs,
    nixos-wsl,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";

      config.allowUnfree = true;

      overlays = [(import inputs.rust-overlay)];
    };
    stateVersion = "26.05";
    username = "ethan";
    specialArgs = {
      inherit stateVersion username;
    };
  in {
    nixosConfigurations."seamoth" = nixpkgs.lib.nixosSystem {
      inherit pkgs specialArgs;

      modules = [
        nixpkgs.nixosModules.readOnlyPkgs
        ./system/seamoth/system.nix
      ];
    };
    nixosConfigurations."snowfox" = nixpkgs.lib.nixosSystem {
      inherit pkgs specialArgs;

      modules = [
        nixpkgs.nixosModules.readOnlyPkgs
        nixos-wsl.nixosModules.default
        ./system/snowfox/system.nix
      ];
    };
    homeConfigurations.${username} = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./home/home.nix];
      extraSpecialArgs = {
        inherit stateVersion username;

        neovim-config = inputs.neovim-config;
        helium-browser = inputs.helium-browser;
      };
    };
  };
}

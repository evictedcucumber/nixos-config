{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-config.url = "github:evictedcucumber/neovim-config/main";
    neovim-config.flake = false;

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    helium-browser.url = "github:vikingnope/helium-browser-nix-flake";
    helium-browser.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    stateVersion = "26.05";
    pkgs = import nixpkgs {
      system = "x86_64-linux";

      config.allowUnfree = true;

      overlays = [(import inputs.rust-overlay)];
    };
  in {
    nixosConfigurations."seamoth" = nixpkgs.lib.nixosSystem {
      inherit pkgs;

      modules = [
        nixpkgs.nixosModules.readOnlyPkgs
        ./system
        ./system/seamoth/system.nix
      ];
      specialArgs = {
        inherit stateVersion;
      };
    };
    nixosConfigurations."snowfox" = nixpkgs.lib.nixosSystem {
      inherit pkgs;

      modules = [
        nixpkgs.nixosModules.readOnlyPkgs
        ./system
        ./system/snowfox/system.nix
      ];
      specialArgs = {
        inherit stateVersion;

        nixos-wsl = inputs.nixos-wsl;
      };
    };
    homeConfigurations."ethan" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./home.nix];
      extraSpecialArgs = {
        inherit stateVersion;

        neovim-config = inputs.neovim-config;
        zen-browser = inputs.zen-browser;
        helium-browser = inputs.helium-browser;
      };
    };
  };
}

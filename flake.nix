{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
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
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    stateVersion = "25.11";
    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;

      overlays = [(import inputs.rust-overlay)];
    };
  in {
    nixosConfigurations."prawnsuit" = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [./system.nix];
      specialArgs = {
        inherit stateVersion;
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

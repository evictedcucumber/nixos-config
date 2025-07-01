{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl/main";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-config.url = "github:evictedcucumber/neovim-config/main";
    neovim-config.flake = false;
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;

      overlays = [(import inputs.rust-overlay)];
    };
  in {
    nixosConfigurations."nixos-wsl" = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [./system/nixos-wsl/configuration.nix];
      specialArgs = {
        nixos-wsl = inputs.nixos-wsl;
        hostname = "nixos-wsl";
      };
    };
    homeConfigurations."ethan" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./home/ethan/home.nix];
      extraSpecialArgs = {
        neovim-config = inputs.neovim-config;
      };
    };
    homeConfigurations."ethan-vaxowave" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./home/ethan-vaxowave/home.nix];
      extraSpecialArgs = {
        neovim-config = inputs.neovim-config;
      };
    };
  };
}

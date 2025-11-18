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
    stateVersion = "25.11";
    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;

      overlays = [(import inputs.rust-overlay)];
    };
    defaultUser = "ethan";
  in {
    nixosConfigurations."nixos-wsl" = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [./system/nixos-wsl/configuration.nix];
      specialArgs = {
        inherit stateVersion;

        nixos-wsl = inputs.nixos-wsl;
        hostname = "nixos-wsl";
        username = defaultUser;
      };
    };
    homeConfigurations."${defaultUser}" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./home/${defaultUser}.nix];
      extraSpecialArgs = {
        inherit stateVersion;

        neovim-config = inputs.neovim-config;
        username = defaultUser;
      };
    };
  };
}

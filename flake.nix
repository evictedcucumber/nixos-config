{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl/main";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-config.url = "github:evictedcucumber/neovim-config/main";
    neovim-config.flake = false;
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;
    };
  in {
    nixosConfigurations."nixos-wsl" = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [./system/nixos-wsl/configuration.nix];
      specialArgs = {
        nixos-wsl = inputs.nixos-wsl;
        username = "ethan";
        hostname = "nixos-wsl";
      };
    };
    homeConfigurations."ethan" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./home/ethan/home.nix];
      extraSpecialArgs = {neovim-config = inputs.neovim-config;};
    };
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [nixd alejandra zsh];
    };
  };
}

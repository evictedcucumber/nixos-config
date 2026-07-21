{
  inputs = {
    # :: BASE INPUTS {
    import-tree.url = "github:vic/import-tree";
    # :: }

    # :: MAIN REPOSITORIES {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # :: }

    # :: PROGRAMS {
    helium-overlay = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty-overlay = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # :: }
  };

  outputs = inputs: let
    mkSystem = import ./utilities/mkSystem.nix {inherit inputs;};
  in {
    nixosConfigurations = {
      seamoth = mkSystem {
        system = "x86_64-linux";
        hostname = "seamoth";
        username = "ethan";
        stateVersion = "26.11";
      };
      snowfox = mkSystem {
        system = "x86_64-linux";
        hostname = "snowfox";
        username = "ethan";
        stateVersion = "26.11";
      };
      tadpole = mkSystem {
        system = "x86_64-linux";
        hostname = "tadpole";
        username = "ethan";
        stateVersion = "26.11";
      };
    };
  };
}

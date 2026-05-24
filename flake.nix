{
  inputs = {
    # :: BASE INPUTS {
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # :: }

    # :: MAIN REPOSITORIES {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # :: }

    # :: WSL {
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # :: }

    # :: PROGRAMS {
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay/80b1f16dba171a70c44c2ee6ec9529876152a7f5";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    television = {
      url = "github:alexpasmantier/television";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # :: }
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.home-manager.flakeModules.home-manager
        inputs.devshell.flakeModule
        (inputs.import-tree ./modules)
      ];
      _module.args = {
        username = "ethan";
      };
    };
}

{
  inputs = {
    # :: BASE INPUTS {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs/nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs/nixpkgs";
    };
    # :: }

    # :: MAIN REPOSITORIES {
    nixpkgs = {
      url = "github:evictedcucumber/nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs/nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs/nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs/nixpkgs";
    };
    # :: }

    # :: PROGRAMS {
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs/nixpkgs";
    };
    ghostty-overlay = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs/nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs/nixpkgs";
    };
    # :: }
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        inputs.treefmt-nix.flakeModule
        ./hosts
      ];

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = inputs.nixpkgs.legacyPackages.${system};

        treefmt = import ./treefmt.nix;

        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.just
            pkgs.lefthook
            config.treefmt.build.wrapper
          ];
          shellHook = ''
            lefthook install >/dev/null
          '';
        };
      };
    };
}

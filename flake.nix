{
  inputs = {
    # :: BASE INPUTS {
    import-tree.url = "github:vic/import-tree";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # :: }

    # :: MAIN REPOSITORIES {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
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
    inherit (inputs.nixpkgs) lib;
    mkSystem = import ./lib/mkSystem.nix {inherit inputs;};

    system = "x86_64-linux";
    username = "ethan";
    hosts = lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./hosts));

    pkgs = import inputs.nixpkgs {inherit system;};
    treefmtEval = inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
  in {
    nixosConfigurations = lib.genAttrs hosts (hostname: mkSystem {inherit system hostname username;});

    packages.${system}.seamoth-iso =
      (lib.nixosSystem {
        specialArgs = {
          inherit username;
          target = inputs.self.nixosConfigurations.seamoth;
        };
        modules = [./modules/nixos/installer.nix];
      }).config.system.build.isoImage;

    formatter.${system} = treefmtEval.config.build.wrapper;

    devShells.${system}.default = pkgs.mkShell {
      packages = [
        pkgs.just
        pkgs.lefthook
        treefmtEval.config.build.wrapper
      ];
      shellHook = ''
        lefthook install >/dev/null
      '';
    };

    checks.${system}.formatting = treefmtEval.config.build.check inputs.self;
  };
}

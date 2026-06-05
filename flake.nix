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

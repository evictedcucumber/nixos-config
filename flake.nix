{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
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
  };

  outputs = {nixpkgs, ...} @ inputs: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";

      config.allowUnfree = true;

      overlays = [
        inputs.nur.overlays.default
        inputs.rust-overlay.overlays.default
        inputs.neovim-nightly-overlay.overlays.default
        inputs.yazi.overlays.default
      ];
    };
    stateVersion = "26.05";
    username = "ethan";
    specialArgs = {inherit stateVersion username inputs;};
    systemConfig = name: extraInputs:
      nixpkgs.lib.nixosSystem {
        inherit pkgs specialArgs;

        modules =
          [
            nixpkgs.nixosModules.readOnlyPkgs
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                overwriteBackup = true;

                extraSpecialArgs = specialArgs;

                users.${username} = import ./home/home.nix;
              };
            }
            ./system/core.nix
            ./system/${name}.nix
          ]
          ++ extraInputs;
      };
  in {
    nixosConfigurations."seamoth" = systemConfig "seamoth" [];
    nixosConfigurations."snowfox" = systemConfig "snowfox" [inputs.nixos-wsl.nixosModules.default];
  };
}

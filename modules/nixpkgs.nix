{
  inputs,
  withSystem,
  ...
}: {
  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;

      config.allowUnfree = true;

      overlays = with inputs; [
        ghostty.overlays.default
        lazygit.overlays.default
        neovim-nightly-overlay.overlays.default
        nix-direnv.overlays.default
        nix-your-shell.overlays.default
        nur.overlays.default
        rust-overlay.overlays.default
        yazi.overlays.default
      ];
    };
  };

  flake.nixosModules.nixpkgsConfiguration = {system, ...}: {
    nixpkgs.pkgs = withSystem system ({pkgs, ...}: pkgs);
  };
}

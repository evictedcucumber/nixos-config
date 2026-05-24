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
        neovim-nightly-overlay.overlays.default
        nur.overlays.default
        rust-overlay.overlays.default
      ];
    };
  };

  flake.nixosModules.nixpkgsConfiguration = {system, ...}: {
    nixpkgs.pkgs = withSystem system ({pkgs, ...}: pkgs);
  };
}

{
  inputs,
  withSystem,
  ...
}: {
  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;

      config.allowUnfree = true;

      overlays = [
        inputs.nur.overlays.default
        inputs.rust-overlay.overlays.default
        inputs.neovim-nightly-overlay.overlays.default
        inputs.yazi.overlays.default
        inputs.ghostty.overlays.default
      ];
    };
  };

  flake.nixosModules.nixpkgsConfiguration = {system, ...}: {
    nixpkgs.pkgs = withSystem system ({pkgs, ...}: pkgs);
  };
}

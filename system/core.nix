{...}: {
  imports = [
    ./modules/boot.nix
    ./modules/environment.nix
    ./modules/fonts.nix
    ./modules/i18n.nix
    ./modules/nix.nix
    ./modules/programs.nix
    ./modules/system.nix
    ./modules/time.nix
    ./modules/user.nix
  ];
}

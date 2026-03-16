{...}: {
  imports = [
    ./modules/boot.nix
    ./modules/environment.nix
    ./modules/fonts.nix
    ./modules/locales.nix
    ./modules/nix.nix
    ./modules/programs.nix
    ./modules/system.nix
    ./modules/time.nix
    ./modules/users.nix
  ];

  me.system.core = {
    boot.enable = true;
    environment.enable = true;
    fonts.enable = true;
    locales.enable = true;
    nix.enable = true;
    programs.enable = true;
    system.enable = true;
    time.enable = true;
    users.enable = true;
  };
}

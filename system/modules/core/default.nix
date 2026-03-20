{...}: {
  imports = [
    ./boot.nix
    ./environment.nix
    ./fonts.nix
    ./locales.nix
    ./networking.nix
    ./nix.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./system.nix
    ./time.nix
    ./users.nix
  ];

  me.system.core = {
    boot.enable = true;
    environment.enable = true;
    fonts.enable = true;
    locales.enable = true;
    nix.enable = true;
    programs.enable = true;
    security.enable = true;
    services.enable = true;
    system.enable = true;
    time.enable = true;
    users.enable = true;
  };
}

{...}: {
  flake.homeModules.nautilus = {pkgs, ...}: {
    home.packages = [pkgs.nautilus];
  };
}

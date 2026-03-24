{...}: {
  flake.homeModules.brave = {pkgs, ...}: {
    home.packages = [pkgs.brave];
  };
}

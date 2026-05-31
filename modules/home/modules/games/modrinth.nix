{...}: {
  flake.homeModules.modrinth = {pkgs, ...}: {
    home.packages = with pkgs; [modrinth-app];
  };
}

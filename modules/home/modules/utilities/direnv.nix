{...}: {
  flake.homeModules.direnv = {pkgs, ...}: {
    programs.direnv = {
      enable = true;
      enableFishIntegration = true;
      silent = true;
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };
  };
}

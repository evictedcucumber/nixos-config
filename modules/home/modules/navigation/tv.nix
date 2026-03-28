{inputs, ...}: {
  flake.homeModules.tv = {pkgs, ...}: {
    programs.television = {
      enable = true;
      # Disabled until new folder structure is added see fix inside fish.nix
      # enableFishIntegration = true;
      package = inputs.television.packages.${pkgs.stdenv.system}.default;
    };

    programs.nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
      package = inputs.nix-search-tv.packages.${pkgs.stdenv.system}.default;
    };
  };
}

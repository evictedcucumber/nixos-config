{inputs, ...}: {
  flake.homeModules.tv = {pkgs, ...}: {
    programs.television = {
      enable = true;
      enableFishIntegration = true;
      package = inputs.television.packages.${pkgs.stdenv.system}.default;
    };

    programs.nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
      package = inputs.nix-search-tv.packages.${pkgs.stdenv.system}.default;
    };
  };
}

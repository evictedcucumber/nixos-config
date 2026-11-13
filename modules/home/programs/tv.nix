_: {
  programs.television = {
    enable = true;
    enableFishIntegration = true;
    # FIX: fish complete source issue
    # package = inputs.television.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      default_channel = "channels";
      ui.theme = "rose-pine";
    };
  };

  programs.nix-search-tv = {
    enable = true;
    enableTelevisionIntegration = true;
  };
}

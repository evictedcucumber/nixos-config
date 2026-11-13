_: {
  programs.television = {
    enable = true;
    enableFishIntegration = true;
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

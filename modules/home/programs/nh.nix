{config, ...}: {
  programs.nh = {
    enable = true;
    flake = config.me.flakePath;
  };
}

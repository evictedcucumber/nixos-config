{config, ...}: {
  programs.bottom.enable = true;

  xdg.configFile."bottom".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/nixos-config/config/bottom";
}

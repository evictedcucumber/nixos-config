{config, ...}: {
  programs.zellij.enable = true;

  xdg.configFile."zellij" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/nixos-config/config/zellij";
    recursive = true;
  };
}

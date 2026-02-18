{...}: {
  programs.zellij.enable = true;

  xdg.configFile = {
    "zellij/config.kdl".source = ../../configs/zellij-config.kdl;
    "zellij/layouts/default.kdl".source = ../../configs/zellij-layout.kdl;
  };
}

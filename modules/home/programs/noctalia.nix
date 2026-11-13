{
  inputs,
  config,
  ...
}: let
  mkSymlink = link: (import ../../../lib/mkSymlink.nix) link config;
in {
  imports = [inputs.noctalia.homeModules.default];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile."noctalia/config.toml".source = mkSymlink "wms/noctalia/config.toml";
}

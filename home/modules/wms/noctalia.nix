{
  inputs,
  lib,
  config,
  ...
}: let
  mkSymlink = link: (import ../../../utilities/mkSymlink.nix) link config;
in {
  imports = [inputs.noctalia.homeModules.default];

  options.me.wms.noctalia.enable = lib.mkEnableOption "Enable Noctalia Shell";

  config = lib.mkIf config.me.wms.noctalia.enable {
    programs.noctalia.enable = true;

    xdg.configFile."noctalia/config.toml".source = mkSymlink "wms/noctalia/config.toml";
  };
}

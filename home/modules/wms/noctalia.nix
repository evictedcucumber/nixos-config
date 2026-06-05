{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.noctalia.homeModules.default];

  options.me.wms.noctalia.enable = lib.mkEnableOption "Enable Noctalia Shell";

  config = lib.mkIf config.me.wms.noctalia.enable {
    programs.noctalia-shell.enable = true;

    xdg.configFile."noctalia/settings.json".source = ../../../config/wms/noctalia/settings.json;
    xdg.configFile."noctalia/plugins.json".source = ../../../config/wms/noctalia/plugins.json;
  };
}

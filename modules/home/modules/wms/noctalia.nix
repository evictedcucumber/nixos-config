{inputs, ...}: {
  flake.homeModules.noctalia = {...}: {
    imports = [inputs.noctalia.homeModules.default];

    programs.noctalia-shell.enable = true;

    xdg.configFile."noctalia/settings.json".source = ../../../../config/wms/noctalia/settings.json;
    xdg.configFile."noctalia/plugins.json".source = ../../../../config/wms/noctalia/plugins.json;
  };
}

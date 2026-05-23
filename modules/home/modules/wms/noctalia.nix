{inputs, ...}: {
  flake.homeModules.noctalia = {...}: {
    imports = [inputs.noctalia.homeModules.default];

    programs.noctalia-shell.enable = true;

    xdg.configFile."noctalia".source = ../../../../config/noctalia;
  };
}

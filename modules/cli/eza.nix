{
  config,
  lib,
  ...
}: {
  options = {
    me.cli.eza.enable = lib.mkEnableOption "Enable EZA";
  };

  config = lib.mkIf config.me.cli.eza.enable {
    programs.eza.enable = true;
  };
}

{
  config,
  lib,
  ...
}: {
  options = {
    me.cli.fastfetch.enable = lib.mkEnableOption "Enable Fastfetch";
  };

  config = lib.mkIf config.me.cli.fastfetch.enable {
    programs.fastfetch.enable = true;
  };
}

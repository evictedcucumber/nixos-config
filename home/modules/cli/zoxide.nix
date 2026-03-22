{
  config,
  lib,
  ...
}: {
  options.me.home.cli.zoxide.enable = lib.mkEnableOption "Enable Zoxide Options";

  config = lib.mkIf config.me.home.cli.zoxide.enable {
    programs.zoxide.enable = true;
  };
}

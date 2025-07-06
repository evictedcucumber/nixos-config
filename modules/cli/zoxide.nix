{
  config,
  lib,
  ...
}: {
  options = {
    me.cli.zoxide.enable = lib.mkEnableOption "Enable Zoxide";
  };

  config = lib.mkIf config.me.cli.zoxide.enable {
    programs.zoxide.enable = true;
  };
}

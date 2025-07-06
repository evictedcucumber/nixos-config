{
  config,
  lib,
  ...
}: {
  options = {
    me.cli.fd.enable = lib.mkEnableOption "Enable FD";
  };

  config = lib.mkIf config.me.cli.fd.enable {
    programs.fd.enable = true;
  };
}

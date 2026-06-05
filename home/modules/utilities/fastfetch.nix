{
  lib,
  config,
  ...
}: {
  options.me.utilities.fastfetch.enable = lib.mkEnableOption "Enable FastFetch";

  config = lib.mkIf config.me.utilities.fastfetch.enable {
    programs.fastfetch.enable = true;
  };
}

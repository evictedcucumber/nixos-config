{
  lib,
  config,
  ...
}: {
  options.me.editors.cursor.enable = lib.mkEnableOption "Enable Cursor Editor";

  config = lib.mkIf config.me.editors.cursor.enable {
    programs.cursor.enable = true;
  };
}

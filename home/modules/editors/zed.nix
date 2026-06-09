{
  lib,
  config,
  ...
}: {
  options.me.editors.zed.enable = lib.mkEnableOption "Enable Zed Editor";

  config = lib.mkIf config.me.editors.zed.enable {
    programs.zed-editor.enable = true;
  };
}

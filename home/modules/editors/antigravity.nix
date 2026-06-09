{
  lib,
  config,
  ...
}: {
  options.me.editors.antigravity.enable = lib.mkEnableOption "Enable Antigravity Editor";

  config = lib.mkIf config.me.editors.antigravity.enable {
    programs.antigravity.enable = true;
  };
}

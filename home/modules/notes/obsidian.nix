{
  lib,
  config,
  ...
}: {
  options.me.notes.obsidian = {
    enable = lib.mkEnableOption "Enable Obsidian Notes";
    cli.enable = lib.mkEnableOption "Enable Obsidian CLI";
  };

  config = lib.mkIf config.me.notes.obsidian.enable {
    programs.obsidian = {
      enable = true;
      cli.enable = config.me.notes.obsidian.cli.enable;
    };
  };
}

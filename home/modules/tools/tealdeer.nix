{
  lib,
  config,
  ...
}: {
  options.me.tools.tealdeer.enable = lib.mkEnableOption "Enable Tealdeer";

  config = lib.mkIf config.me.tools.tealdeer.enable {
    programs.tealdeer = {
      enable = true;
      enableAutoUpdates = true;
      settings = {
        display.use_pager = true;
        directories.cache_dir = "${config.xdg.cacheHome}/tealdeer";
        updates.auto_update = true;
      };
    };
  };
}

{
  config,
  lib,
  ...
}: {
  options.me.home.cli.tealdeer.enable = lib.mkEnableOption "Enable Tealdeer Options";

  config = lib.mkIf config.me.home.cli.tealdeer.enable {
    programs.tealdeer = {
      enable = true;
      settings = {
        display.use_pager = true;
        directories.cache_dir = "${config.xdg.cacheHome}/tealdeer";
        updates.auto_update = true;
      };
    };
  };
}

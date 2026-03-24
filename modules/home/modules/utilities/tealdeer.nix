{...}: {
  flake.homeModules.tealdeer = {config, ...}: {
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

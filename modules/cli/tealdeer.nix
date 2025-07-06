{
  lib,
  config,
  ...
}: {
  options = {
    me.cli.tealdeer.enable = lib.mkEnableOption "Enable tealdeer";
  };

  config = lib.mkIf config.me.cli.tealdeer.enable {
    programs.tealdeer = {
      enable = true;
      settings = {
        display = {
          use_pager = true;
        };
        directories = {
          cache_dir = "${config.xdg.cacheHome}/tealdeer";
        };
        updates = {
          auto_update = true;
        };
      };
    };
  };
}

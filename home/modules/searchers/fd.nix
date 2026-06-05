{
  lib,
  config,
  ...
}: {
  options.me.searchers.fd.enable = lib.mkEnableOption "Enable FD Searcher";

  config = lib.mkIf config.me.searchers.fd.enable {
    programs.fd = {
      enable = true;
      hidden = true;
    };
  };
}

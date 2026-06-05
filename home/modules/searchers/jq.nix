{
  lib,
  config,
  ...
}: {
  options.me.searchers.jq.enable = lib.mkEnableOption "Enable JQ Searcher";

  config = lib.mkIf config.me.searchers.jq.enable {
    programs.jq.enable = true;
  };
}

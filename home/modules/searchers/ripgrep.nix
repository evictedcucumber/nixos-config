{
  lib,
  config,
  ...
}: {
  options.me.searchers.ripgrep.enable = lib.mkEnableOption "Enable RipGrep Searcher";

  config = lib.mkIf config.me.searchers.ripgrep.enable {
    programs.ripgrep = {
      enable = true;
      arguments = ["--color=always"];
    };
  };
}

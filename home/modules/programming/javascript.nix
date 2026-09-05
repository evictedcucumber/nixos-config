{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.programming.javascript.enable = lib.mkEnableOption "Enable Javascript Compiler";

  config = lib.mkIf config.me.programming.javascript.enable {
    home = {
      packages = with pkgs; [nodejs_latest];

      file.".npmrc".text = ''
        prefix = ''${XDG_DATA_HOME}/npm
        cache = ''${XDG_CACHE_HOME}/npm
      '';

      sessionPath = [
        "$XDG_DATA_HOME/npm/bin"
      ];
    };

    programs.yarn.enable = true;
  };
}

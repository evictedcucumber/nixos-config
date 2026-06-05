{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.databases.sqlite.enable = lib.mkEnableOption "Enable SQLite Database";

  config = lib.mkIf config.me.databases.sqlite.enable {
    home.packages = with pkgs; [sqlite];
  };
}

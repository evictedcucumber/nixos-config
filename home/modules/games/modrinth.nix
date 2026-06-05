{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.games.modrinth.enable = lib.mkEnableOption "Enable Modrinth";

  config = lib.mkIf config.me.games.modrinth.enable {
    home.packages = with pkgs; [modrinth-app];
  };
}

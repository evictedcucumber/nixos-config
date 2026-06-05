{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.programming.lua.enable = lib.mkEnableOption "Enable Lua";

  config = lib.mkIf config.me.programming.lua.enable {
    home.packages = with pkgs; [luajit luarocks];
  };
}

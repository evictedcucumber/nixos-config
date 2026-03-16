{
  pkgs,
  username,
  lib,
  config,
  ...
}: {
  options.me.system.core.users.enable = lib.mkEnableOption "Enable User Options";

  config = lib.mkIf config.me.system.core.users.enable {
    users.users."${username}" = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.fish;
    };
  };
}

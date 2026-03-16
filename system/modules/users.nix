{
  pkgs,
  username,
  lib,
  config,
  ...
}: {
  options.me.system.core.users = {
    enable = lib.mkEnableOption "Enable User Options";
    extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Extra groups to add to the user";
    };
  };

  config = lib.mkIf config.me.system.core.users.enable {
    users.users."${username}" = {
      isNormalUser = true;
      extraGroups = ["wheel"] ++ config.me.system.core.users.extraGroups;
      shell = pkgs.fish;
    };
  };
}

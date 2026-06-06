{
  lib,
  config,
  ...
}: {
  options.me.navigation.zoxide.enable = lib.mkEnableOption "Enable Zoxide Navigation";

  config = lib.mkIf config.me.navigation.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = config.me.shells.fish.integrations.enable;
    };
  };
}

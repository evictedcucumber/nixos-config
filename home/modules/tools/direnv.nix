{
  lib,
  config,
  ...
}: {
  options.me.tools.direnv.enable = lib.mkEnableOption "Enable Direnv";

  config = lib.mkIf config.me.tools.direnv.enable {
    programs.direnv = {
      enable = true;
      enableFishIntegration = config.me.shells.fish.integrations.enable;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}

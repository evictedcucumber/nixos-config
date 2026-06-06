{
  lib,
  config,
  ...
}: {
  options.me.utilities.nix-your-shell.enable = lib.mkEnableOption "Enable Nix-Your-Shell";

  config = lib.mkIf config.me.utilities.nix-your-shell.enable {
    programs.nix-your-shell = {
      enable = true;
      enableFishIntegration = config.me.shells.fish.integrations.enable;
      nix-output-monitor.enable = true;
    };
  };
}

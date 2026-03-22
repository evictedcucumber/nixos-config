{
  config,
  lib,
  ...
}: {
  options.me.home.cli.nix-your-shell.enable = lib.mkEnableOption "Enable Nix-Your-Shell Options";

  config = lib.mkIf config.me.home.cli.nix-your-shell.enable {
    programs.nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}

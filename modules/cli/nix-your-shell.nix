{
  config,
  lib,
  ...
}: {
  options = {
    me.cli.nix-your-shell.enable = lib.mkEnableOption "Enable nix-your-shell";
    me.cli.nix-your-shell.enableFish = lib.mkEnableOption "Enable Fish Integration";
  };

  config = lib.mkIf config.me.cli.nix-your-shell.enable {
    programs.nix-your-shell = {
      enable = true;
      enableFishIntegration = config.me.cli.nix-your-shell.enableFish;
    };
  };
}

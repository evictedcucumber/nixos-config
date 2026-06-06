{
  lib,
  config,
  ...
}: {
  options.me.navigation.tv.enable = lib.mkEnableOption "Enable TV Navigation";

  config = lib.mkIf config.me.navigation.tv.enable {
    programs.television = {
      enable = true;
      enableFishIntegration = config.me.shells.fish.integrations.enable;
      # FIX: fish complete source issue
      # package = inputs.television.packages.${pkgs.stdenv.hostPlatform.system}.default;
      settings = {
        default_channel = "channels";
        ui.theme = "rose-pine";
      };
    };

    programs.nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
    };
  };
}

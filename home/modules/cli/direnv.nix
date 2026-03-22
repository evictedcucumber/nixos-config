{
  config,
  lib,
  ...
}: {
  options.me.home.cli.direnv.enable = lib.mkEnableOption "Enable Direnv Options";

  config = lib.mkIf config.me.home.cli.direnv.enable {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}

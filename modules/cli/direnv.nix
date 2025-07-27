{
  config,
  lib,
  ...
}
: {
  options = {
    me.cli.direnv.enable = lib.mkEnableOption "Enable direnv";
  };

  config = lib.mkIf config.me.cli.direnv.enable {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}

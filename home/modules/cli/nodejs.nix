{
  pkgs,
  config,
  lib,
  ...
}: {
  options.me.home.cli.nodejs.enable = lib.mkEnableOption "Enable NodeJS Options";

  config = lib.mkIf config.me.home.cli.nodejs.enable {
    home.packages = with pkgs; [nodejs];

    home.file.".npmrc".text = ''
      prefix = ''${HOME}/.npm-global
    '';

    home.sessionPath = [
      "$HOME/.npm-global/bin"
    ];
  };
}

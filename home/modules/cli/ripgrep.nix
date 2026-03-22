{
  config,
  lib,
  ...
}: {
  options.me.home.cli.ripgrep.enable = lib.mkEnableOption "Enable Ripgrep Options";

  config = lib.mkIf config.me.home.cli.ripgrep.enable {
    programs.ripgrep = {
      enable = true;
      arguments = ["--color=always"];
    };
  };
}

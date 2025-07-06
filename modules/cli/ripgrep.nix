{
  config,
  lib,
  ...
}: {
  options = {
    me.cli.ripgrep.enable = lib.mkEnableOption "Enable Ripgrep";
  };

  config = lib.mkIf config.me.cli.ripgrep.enable {
    programs.ripgrep = {
      enable = true;
      arguments = ["--color=always"];
    };
  };
}

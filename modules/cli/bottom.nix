{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {me.cli.bottom.enable = lib.mkEnableOption "Enable bottom";};

  config = lib.mkIf config.me.cli.bottom.enable {
    programs.bottom.enable = true;
    home.file.".config/bottom/bottom.toml".source = builtins.fetchurl {
      url = "https://github.com/catppuccin/bottom/raw/main/themes/mocha.toml";
      sha256 = "1bvgr6xhhk9l34ndypia4vjgdmaxlz4qnka99ivr3krgx8iwf60r";
    };
  };
}

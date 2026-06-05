{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.programming.latex.enable = lib.mkEnableOption "Enable Latex Compiler";

  config = lib.mkIf config.me.programming.latex.enable {
    home.packages = with pkgs; [tectonic];

    programs.texlive.enable = true;
  };
}

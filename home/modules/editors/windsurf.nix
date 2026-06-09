{
  lib,
  config,
  pkgs,
  ...
}: let
  windsurfWrapped = pkgs.symlinkJoin {
    name = "windsurf-wrapped";
    paths = [pkgs.windsurf];

    buildInputs = [pkgs.makeWrapper];

    postBuild = ''
      wrapProgram $out/bin/windsurf \
        --set XDG_CURRENT_DESKTOP GNOME
    '';
  };
in {
  options.me.editors.windsurf.enable = lib.mkEnableOption "Enable Windsurf Editor";

  config = lib.mkIf config.me.editors.windsurf.enable {
    programs.windsurf = {
      enable = true;
      package = windsurfWrapped;
    };
  };
}

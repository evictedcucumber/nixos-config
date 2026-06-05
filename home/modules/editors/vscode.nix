{
  lib,
  config,
  pkgs,
  ...
}: let
  vscodeWrapped = pkgs.symlinkJoin {
    name = "vscode-wrapped";
    paths = [pkgs.vscode];

    buildInputs = [pkgs.makeWrapper];

    postBuild = ''
      wrapProgram $out/bin/code \
        --set XDG_CURRENT_DESKTOP GNOME
    '';
  };
in {
  options.me.editors.vscode.enable = lib.mkEnableOption "Enable VS Code Editor";

  config = lib.mkIf config.me.editors.vscode.enable {
    programs.vscode = {
      enable = true;
      package = vscodeWrapped;
    };
  };
}

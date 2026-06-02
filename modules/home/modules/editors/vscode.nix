{...}: {
  flake.homeModules.vscode = {pkgs, ...}: let
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
    programs.vscode = {
      enable = true;
      package = vscodeWrapped;
    };
  };
}

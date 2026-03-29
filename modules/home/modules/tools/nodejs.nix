{...}: {
  flake.homeModules.nodejs = {pkgs, ...}: {
    home.packages = with pkgs; [nodejs_latest];

    home.file.".npmrc".text = ''
      prefix = ''${HOME}/.npm-global
    '';

    home.sessionPath = [
      "$HOME/.npm-global/bin"
    ];
  };
}

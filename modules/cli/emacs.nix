{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    me.cli.emacs.enable = lib.mkEnableOption "Enable Emacs";
  };

  config = lib.mkIf config.me.cli.emacs.enable {
    home.packages = with pkgs; [emacs-gtk ripgrep fd cmake nerd-fonts.jetbrains-mono];
    home.sessionPath = ["$HOME/.config/emacs/bin"];
    services.emacs.enable = true;
    services.emacs.package = pkgs.emacs-gtk;
  };
}

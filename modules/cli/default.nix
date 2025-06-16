{
  lib,
  config,
  ...
}: {
  imports = [
    ./shells
    ./yazi
    ./tmux.nix
    ./emacs.nix
    ./neovim.nix
    ./git.nix
    ./lazygit.nix
    ./bottom.nix
    ./tealdeer.nix
  ];

  options = {me.cli.enable = lib.mkEnableOption "Enable CLI Tools";};

  config = lib.mkIf config.me.cli.enable {
    me.cli.shells.enable = true;
    me.cli.yazi.enable = true;
    me.cli.tmux.enable = true;
    me.cli.emacs.enable = false;
    me.cli.neovim.enable = true;
    me.cli.git.enable = true;
    me.cli.lazygit.enable = true;
    me.cli.bottom.enable = true;
    me.cli.tealdeer.enable = true;
  };
}

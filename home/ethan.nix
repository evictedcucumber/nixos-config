{
  config,
  stateVersion,
  username,
  ...
}: {
  imports = [
    ../modules/cli/fish.nix
    ../modules/cli/fzf.nix
    ../modules/cli/starship.nix
    ../modules/cli/fd.nix
    ../modules/cli/yazi
    ../modules/cli/neovim.nix
    ../modules/cli/git.nix
    ../modules/cli/lazygit.nix
    ../modules/cli/tealdeer.nix
    ../modules/cli/direnv.nix
    ../modules/cli/zellij
    ../modules/gui/wezterm
    ../modules/gui/ghostty.nix
    ../modules/gui/zen-browser.nix
  ];

  home.username = "${username}";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = stateVersion;

  me.cli.fish.enable = true;
  me.cli.starship.enable = true;
  me.cli.neovim.enable = true;
  me.cli.lazygit.enable = true;
  me.cli.tealdeer.enable = true;
  me.cli.zellij.enable = true;
  me.cli.direnv.enable = true;
  me.cli.git = {
    enable = true;
    gpgKey = "9ECE1D3B3AAE0D67";
  };
  me.cli.yazi = {
    enable = true;
    enableFish = true;
  };
  me.gui.wezterm.enable = true;
  me.gui.ghostty = {
    enable = true;
    enableFish = true;
  };
  me.gui.zen-browser.enable = true;

  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.local/cache";
  };

  programs.home-manager.enable = true;
}

{
  config,
  pkgs,
  stateVersion,
  ...
}: {
  imports = [
    ../modules/cli/fish.nix
    ../modules/cli/fzf.nix
    ../modules/cli/starship.nix
    ../modules/cli/fd.nix
    ../modules/cli/yazi
    ../modules/cli/tmux.nix
    ../modules/cli/neovim.nix
    ../modules/cli/git.nix
    ../modules/cli/lazygit.nix
    ../modules/cli/tealdeer.nix
  ];

  home.username = "ethan-vaxowave";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = stateVersion;

  me.cli.fish.enable = true;
  me.cli.starship.enable = true;
  me.cli.tmux.enable = true;
  me.cli.neovim.enable = true;
  me.cli.lazygit.enable = true;
  me.cli.tealdeer.enable = true;
  me.cli.git = {
    enable = true;
    gpgKey = "8E29907A4CA30E30";
  };
  me.cli.yazi = {
    enable = true;
    enableFish = true;
  };

  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.local/cache";
  };

  home.packages = with pkgs; [azure-cli];

  programs.home-manager.enable = true;
}

{
  self,
  username,
  ...
}: {
  flake.homeModules.sharedHomeConfiguration = {config, ...}: {
    imports = with self.homeModules; [
      bat
      direnv
      fish
      fzf
      git
      hledger
      java
      lazygit
      neovim
      nh
      nix-your-shell
      nodejs
      ripgrep
      ssh
      starship
      tv
      yazi
      zellij
      zoxide
    ];

    home = {
      inherit username;
      stateVersion = "26.05";
      homeDirectory = "/home/${username}";
    };

    xdg = {
      enable = true;
      configHome = "${config.home.homeDirectory}/.config";
      dataHome = "${config.home.homeDirectory}/.local/share";
      stateHome = "${config.home.homeDirectory}/.local/state";
      cacheHome = "${config.home.homeDirectory}/.local/cache";
    };
  };
}

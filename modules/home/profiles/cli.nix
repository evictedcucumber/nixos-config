# Shell, prompt and everyday command-line tools.
{pkgs, ...}: {
  imports = [
    ../programs/bat.nix
    ../programs/direnv.nix
    ../programs/eza.nix
    ../programs/fish.nix
    ../programs/fzf.nix
    ../programs/git.nix
    ../programs/lazygit.nix
    ../programs/nh.nix
    ../programs/ssh.nix
    ../programs/starship.nix
    ../programs/tealdeer.nix
    ../programs/tmux.nix
    ../programs/tv.nix
    ../programs/yazi.nix
  ];

  home.packages = with pkgs; [
    curlFull
    sqlite
    unzip
    wget
    wget2
    zip
  ];

  programs = {
    fastfetch.enable = true;
    fd = {
      enable = true;
      hidden = true;
    };
    jq.enable = true;
    nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
      nix-output-monitor.enable = true;
    };
    ripgrep.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}

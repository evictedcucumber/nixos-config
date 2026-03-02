{pkgs, ...}: {
  imports = [./ghostty.nix];

  home.packages = with pkgs; [
    brave
    obsidian
    pkgs.nur.repos.Ev357.helium
  ];
}

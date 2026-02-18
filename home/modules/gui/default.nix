{
  pkgs,
  helium-browser,
  ...
}: {
  imports = [./ghostty.nix];

  home.packages = with pkgs; [
    brave
    obsidian
    helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}

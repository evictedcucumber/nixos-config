# Graphical session shared by non-WSL hosts.
{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./hyprland.nix
    ./power.nix
  ];

  # :: SERVICES {
  services.gvfs.enable = true;
  # :: }

  # :: FONT {
  fonts.packages = with pkgs; [
    inter
    nerd-fonts.jetbrains-mono
  ];
  # :: }

  # :: ENVIRONMENT {
  environment.systemPackages = with pkgs; [
    pinentry-all
    gcr_4
  ];
  # :: }
}

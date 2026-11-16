# Graphical session shared by non-WSL hosts.
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixpkgs.nixosModules.helium
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
  environment.systemPackages = [pkgs.gcr_4];
  # :: }

  # :: PROGRAMS {
  programs.helium.enable = true;
  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-all;
  # :: }
}

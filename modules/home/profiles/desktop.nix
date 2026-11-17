# Hyprland session and graphical apps.
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.my-nixpkgs.homeModules.helium
    ../programs/flameshot.nix
    ../programs/ghostty.nix
    ../programs/hyprland.nix
    ../programs/noctalia.nix
    ../programs/theme.nix
    ../programs/vscode.nix
  ];

  home.packages = with pkgs; [
    nautilus
    spotify
  ];

  programs = {
    helium.enable = true;
    mpv.enable = true;
    obsidian.enable = true;
  };
}

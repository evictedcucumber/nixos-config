# Hyprland session and graphical apps.
{pkgs, ...}: {
  imports = [
    ../programs/flameshot.nix
    ../programs/ghostty.nix
    ../programs/hyprland.nix
    ../programs/noctalia.nix
    ../programs/theme.nix
    ../programs/vscode.nix
  ];

  home.packages = with pkgs; [
    helium
    # modrinth-app
    nautilus
    spotify
  ];

  programs = {
    mpv.enable = true;
    obsidian.enable = true;
  };

  # :: XDG {
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };
  # :: }
}

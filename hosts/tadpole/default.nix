{pkgs, ...}: {
  imports = [../../modules/nixos/wsl.nix];

  # :: SYSTEM {
  system.stateVersion = "26.11";
  # :: }

  # :: WSL {
  # Use the WSL default of appending the Windows PATH, so Windows tools
  # such as VS Code's `code` resolve from here.
  wsl.wslConf.interop.appendWindowsPath = true;
  # :: }

  # :: PROGRAMS {
  programs.nix-ld.libraries = with pkgs; [stdenv.cc.cc.lib libxcrypt-legacy];
  # :: }
}

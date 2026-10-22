{
  pkgs,
  username,
  ...
}: {
  imports = [./wsl.nix];

  # :: WSL {
  # Use the WSL default of appending the Windows PATH, so Windows tools
  # such as VS Code's `code` resolve from here.
  wsl.wslConf.interop.appendWindowsPath = true;
  # :: }

  # :: PROGRAMS {
  programs.nix-ld.libraries = with pkgs; [stdenv.cc.cc.lib libxcrypt-legacy];
  # :: }

  # :: HOME {
  home-manager.users.${username} = import ../home/tadpole.nix;
  # :: }
}

{
  pkgs,
  username,
  ...
}: {
  imports = [./wsl.nix];

  # :: PROGRAMS {
  programs.nix-ld.libraries = [pkgs.stdenv.cc.cc.lib];
  # :: }

  # :: HOME {
  home-manager.users.${username} = import ../home/tadpole.nix;
  # :: }
}

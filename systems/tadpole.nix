{
  pkgs,
  username,
  ...
}: {
  imports = [./wsl.nix];

  # :: PROGRAMS {
  programs.nix-ld.libraries = with pkgs; [stdenv.cc.cc.lib libxcrypt-legacy];
  # :: }

  # :: HOME {
  home-manager.users.${username} = import ../home/tadpole.nix;
  # :: }
}

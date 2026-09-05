{username, ...}: {
  imports = [./wsl.nix];

  # :: HOME {
  home-manager.users.${username} = import ../home/tadpole.nix;
  # :: }
}

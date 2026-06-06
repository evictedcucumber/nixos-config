{
  inputs,
  pkgs,
  username,
  ...
}: {
  imports = [inputs.nixos-wsl.nixosModules.default];

  # :: WSL {
  wsl = {
    enable = true;
    wslConf.interop.appendWindowsPath = false;
    defaultUser = "${username}";
    interop.register = true;
  };
  # :: }

  # :: ENVIRONMENT {
  environment.systemPackages = with pkgs; [xclip xsel];
  # :: }

  # :: HOME {
  home-manager.users.${username} = import ../home/tadpole.nix;
  # :: }
}

{
  inputs,
  lib,
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

  # :: SERVICES {
  # xserver has no real display to serve under WSL; WSLg handles GUI apps separately.
  services.xserver.enable = lib.mkForce false;
  # :: }

  # :: ENVIRONMENT {
  environment.systemPackages = with pkgs; [xclip xsel];
  # :: }
}

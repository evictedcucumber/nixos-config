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
  environment.systemPackages = with pkgs; [
    xclip
    xsel
    wsl-open
    # `wslu` (which provided `wslview`) was removed from nixpkgs; this shim
    # gives `vim.ui.open()` (and anything else looking for `wslview`) a
    # binary under the name it actually checks for.
    (writeShellScriptBin "wslview" ''exec ${wsl-open}/bin/wsl-open "$@"'')
  ];
  # :: }
}

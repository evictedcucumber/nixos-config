{
  pkgs,
  username,
  ...
}: {
  imports = [../../system];

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  wsl.enable = true;
  wsl.wslConf.interop.appendWindowsPath = false;

  networking.hostName = "snowfox";

  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "libvirtd" "kvm"];
    shell = pkgs.fish;
  };
  nix.settings.trusted-users = [username];
  wsl.defaultUser = username;
}

{
  pkgs,
  nixos-wsl,
  ...
}: let
  username = "ethan";
in {
  import = [nixos-wsl.nixosModules.default];

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  wsl.enable = true;

  networking.hostName = "snowfox";

  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "libvirtd" "kvm"];
    shell = pkgs.fish;
  };
  nix.settings.trusted-users = [username];
  wsl.defaultUser = username;
}

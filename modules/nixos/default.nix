{
  pkgs,
  hostname,
  username,
  ...
}: {
  imports = [
    ./locale.nix
    ./nix.nix
    ./security.nix
  ];

  # :: BOOT {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # :: }

  # :: NETWORKING {
  networking.hostName = hostname;
  # :: }

  # :: SERVICES {
  services = {
    fwupd.enable = true;
    fstrim.enable = true;
  };
  # :: }

  # :: USERS {
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.fish;
  };
  # :: }

  # :: ENVIRONMENT {
  environment.systemPackages = with pkgs; [
    kmod
    usbutils
    vim
  ];
  # :: }

  # :: PROGRAMS {
  programs.fish.enable = true;
  # :: }
}

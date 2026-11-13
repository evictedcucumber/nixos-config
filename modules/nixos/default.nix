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

  # :: NETWORKING {
  networking.hostName = hostname;
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

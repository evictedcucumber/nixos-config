{
  pkgs,
  nixos-wsl,
  ...
}: {
  imports = [
    ../../system
    nixos-wsl.nixosModules.wsl
  ];

  wsl.enable = true;
  wsl.defaultUser = "ethan";

  programs.fish.enable = true;
  users.users."ethan" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.fish;
  };

  fileSystems."/mnt/mydrive" = {
    device = "G:/My\\040Drive";
    fsType = "drvfs";
    options = ["dmask=0077" "fmask=0177" "gid=100" "uid=1000"];
  };
}

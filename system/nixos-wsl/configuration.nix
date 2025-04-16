{
  pkgs,
  nixos-wsl,
  username,
  ...
}: {
  imports = [
    ../../system
    nixos-wsl.nixosModules.wsl
  ];

  wsl.enable = true;
  wsl.defaultUser = "${username}";

  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };

  fileSystems."/mnt/mydrive" = {
    device = "G:/My\\040Drive";
    fsType = "drvfs";
    options = ["dmask=0077" "fmask=0177" "gid=100" "uid=1000"];
  };
}

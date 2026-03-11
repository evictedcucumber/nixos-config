{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  boot.initrd.luks.devices.cryptlvm = {
    device = "/dev/disk/by-uuid/d4398137-3f81-4596-b493-e019977485af";
    preLVM = true;
    allowDiscards = true;
  };

  fileSystems."/" = {
    device = "/dev/vg/root";
    fsType = "btrfs";
    options = ["subvol=@"];
  };

  fileSystems."/home" = {
    device = "/dev/vg/root";
    fsType = "btrfs";
    options = ["subvol=@home"];
  };

  fileSystems."/nix" = {
    device = "/dev/vg/root";
    fsType = "btrfs";
    options = ["subvol=@nix"];
  };

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p2";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [
    {device = "/dev/vg/swap";}
  ];

  networking.useDHCP = lib.mkDefault true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

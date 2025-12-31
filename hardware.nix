{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = [];
      luks.devices."luks-c02f9b18-6f5d-4c08-93e1-43437008c247".device = "/dev/disk/by-uuid/c02f9b18-6f5d-4c08-93e1-43437008c247";
    };
    kernelModules = ["kvm-intel"];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/114573e9-ab24-4b20-b8aa-51da82752a1b";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/BBF7-C448";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/7c8fd660-3194-4d38-8389-0ead6f24a254";}
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

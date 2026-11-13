{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./hardware.nix
    ../../modules/nixos/desktop
  ];

  # :: SYSTEM {
  system.stateVersion = "26.11";
  # :: }

  # :: BOOT {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi = {
        efiSysMountPoint = "/boot/efi";
        canTouchEfiVariables = true;
      };
    };
  };
  # :: }

  # :: HARDWARE {
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth.enable = true;
  };
  # :: }

  # :: NETWORKING {
  networking = {
    # DNS and DHCP for libvirt guests.
    firewall.interfaces.virbr0 = {
      allowedTCPPorts = [53];
      allowedUDPPorts = [53 67];
    };
    networkmanager.enable = true;
  };
  # :: }

  # :: SERVICES {
  services = {
    fwupd.enable = true;
    fstrim.enable = true;
    printing.enable = true;
    snapper = {
      configs = {
        root = {
          SUBVOLUME = "/";
          TIMELINE_CREATE = true;
          TIMELINE_CLEANUP = true;
          TIMELINE_LIMIT_HOURLY = "0";
          TIMELINE_LIMIT_DAILY = "0";
          TIMELINE_LIMIT_WEEKLY = "7";
          TIMELINE_LIMIT_MONTHLY = "0";
          TIMELINE_LIMIT_YEARLY = "0";
        };
        home = {
          SUBVOLUME = "/home";
          TIMELINE_CREATE = true;
          TIMELINE_CLEANUP = true;
          TIMELINE_LIMIT_HOURLY = "0";
          TIMELINE_LIMIT_DAILY = "7";
          TIMELINE_LIMIT_WEEKLY = "7";
          TIMELINE_LIMIT_MONTHLY = "0";
          TIMELINE_LIMIT_YEARLY = "0";
        };
      };
      snapshotRootOnBoot = true;
    };
  };
  # :: }

  # :: SYSTEMD {
  # Snapper needs these to be subvolumes and doesn't create them itself.
  systemd.tmpfiles.rules = [
    "v /.snapshots 0750 root root -"
    "v /home/.snapshots 0750 root root -"
  ];
  # :: }

  # :: VIRTUALISATION {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  # :: }

  # :: USERS {
  users.users.${username}.extraGroups = ["networkmanager" "libvirtd" "kvm"];
  # :: }

  # :: PROGRAMS {
  programs = {
    virt-manager.enable = true;
    steam = {
      enable = true;
      extraPackages = with pkgs; [javaPackages.compiler.openjdk21];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
  # :: }
}

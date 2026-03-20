{
  pkgs,
  username,
  inputs,
  lib,
  ...
}: {
  me.system.core.users.extraGroups = ["networkmanager" "libvirtd" "kvm"];
  me.system.core.environment.extraPackages = with pkgs; [
    (
      catppuccin-sddm.override {
        flavor = "mocha";
        accent = "rosewater";
        font = "Inter";
        fontSize = "9";
        loginBackground = true;
      }
    )
    weston
  ];

  # Networking Options
  me.system.core.networking.hostName = "seamoth";

  networking = {
    networkmanager.enable = true;
    firewall.trustedInterfaces = ["virbr0"];
    useDHCP = lib.mkDefault true;
  };

  # Boot Options
  boot = {
    loader = {
      systemd-boot.enable = true;
      grub.useOSProber = false;
      efi = {
        efiSysMountPoint = "/boot/efi";
        canTouchEfiVariables = true;
      };
    };
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = ["dm-snapshot"];
      luks.devices.cryptlvm = {
        device = "/dev/disk/by-uuid/d4398137-3f81-4596-b493-e019977485af";
        preLVM = true;
        allowDiscards = true;
      };
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  # System Programs
  programs = {
    hyprland = let
      hyprPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable = true;
      package = hyprPackage.hyprland;
      portalPackage = hyprPackage.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };
    virt-manager.enable = true;
    steam = {
      enable = true;
      extraPackages = with pkgs; [javaPackages.compiler.openjdk21];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };

  # System Services
  services = {
    displayManager = {
      gdm.enable = false;
      sddm = {
        enable = true;
        autoNumlock = true;
        theme = "catppuccin-mocha-rosewater";
      };
    };
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
        nix = {
          SUBVOLUME = "/nix";
          TIMELINE_CREATE = true;
          TIMELINE_CLEANUP = true;
          TIMELINE_LIMIT_HOURLY = "0";
          TIMELINE_LIMIT_DAILY = "0";
          TIMELINE_LIMIT_WEEKLY = "7";
          TIMELINE_LIMIT_MONTHLY = "0";
          TIMELINE_LIMIT_YEARLY = "0";
        };
      };
      snapshotRootOnBoot = true;
    };
    udev.extraRules = let
      ppd = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl";
      sysrun = "${pkgs.systemd}/bin/systemd-run";
    in ''
      # Plugged in → performance
      SUBSYSTEM=="power_supply", KERNEL=="AC*", ATTR{online}=="1", \
        RUN+="${sysrun} --no-block ${ppd} set performance"

      # Unplugged → balanced
      SUBSYSTEM=="power_supply", KERNEL=="AC*", ATTR{online}=="0", \
        RUN+="${sysrun} --no-block ${ppd} set balanced"

      # Battery ≤15% while discharging → power-saver
      SUBSYSTEM=="power_supply", KERNEL=="BAT*", \
        ATTR{status}=="Discharging", ATTR{capacity}=="15", \
        RUN+="${sysrun} --no-block ${ppd} set power-saver"
    '';
  };

  # Virtualisation
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

  # Hardware
  hardware = {
    cpu.intel.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth.enable = true;
    firmware = with pkgs; [linux-firmware];
  };

  # File Systems
  fileSystems = {
    "/" = {
      device = "/dev/vg/root";
      fsType = "btrfs";
      options = ["subvol=@"];
    };
    "/home" = {
      device = "/dev/vg/root";
      fsType = "btrfs";
      options = ["subvol=@home"];
    };
    "/nix" = {
      device = "/dev/vg/root";
      fsType = "btrfs";
      options = ["subvol=@nix"];
    };
    "/boot" = {
      device = "/dev/nvme0n1p2";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  swapDevices = [
    {device = "/dev/vg/swap";}
  ];

  home-manager.users.${username} = {
    imports = [
      inputs.noctalia.homeModules.default
      ../home/modules/cli
      ../home/modules/tui
      ../home/modules/gui
      ../home/modules/gui/hyprland.nix
    ];

    me.cli.git.signingkey = "CB029F0E386B37C7";
  };
}

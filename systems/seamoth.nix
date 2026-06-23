{
  lib,
  pkgs,
  username,
  ...
}: {
  # :: BOOT {
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
  # :: }

  # :: HARDWARE {
  hardware = {
    cpu.intel.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth.enable = true;
    firmware = with pkgs; [linux-firmware];
  };
  # :: }

  # :: FILE SYSTEMS {
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
  # :: }

  # :: SWAP {
  swapDevices = [{device = "/dev/vg/swap";}];
  # :: }

  # :: NIX {
  nix.settings = {
    extra-substituters = ["https://noctalia.cachix.org"];
    extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
  };
  # :: }

  # :: NETWORKING {
  networking = {
    firewall.trustedInterfaces = ["virbr0"];
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
  # :: }

  # :: SECURITY {
  security.pam.services = {
    greetd.enableGnomeKeyring = true;
  };
  # :: }

  # :: SERVICES {
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    displayManager = {
      gdm.enable = false;
      sddm.enable = false;
    };
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --sessions /run/current-system/sw/share/wayland-sessions --time --remember --remember-session";
          user = "greeter";
        };
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
    gvfs.enable = true;
  };
  # :: }

  # :: SYSTEMD {
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
  # :: }

  # :: VIRTUALISATION :: {
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

  # :: FONT {
  fonts.packages = with pkgs; [
    inter
    nerd-fonts.jetbrains-mono
  ];
  # :: }

  # :: USERS {
  users.users.${username}.extraGroups = ["networkmanager" "libvirtd" "kvm"];
  # :: }

  # :: ENVIRONMENT {
  environment.systemPackages = with pkgs; [
    pinentry-all
    wl-clipboard
    wl-clipboard-x11
    gcr
  ];
  # :: }

  # :: PROGRAMS {
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
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
  # :: }

  # :: HOME {
  home-manager.users.${username} = import ../home/seamoth.nix;
  # :: }
}

{
  pkgs,
  username,
  inputs,
  lib,
  ...
}: {
  networking = {
    hostName = "seamoth";
    networkmanager.enable = true;
    firewall.trustedInterfaces = ["virbr0"];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      grub.useOSProber = false;
      efi = {
        efiSysMountPoint = "/boot/efi";
        canTouchEfiVariables = true;
      };
    };
  };

  security.sudo.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  services = {
    pcscd.enable = true;
    displayManager = {
      gdm.enable = false;
      sddm = {
        enable = true;
        autoNumlock = true;
        theme = "catppuccin-mocha-rosewater";
      };
    };
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      xkb = {
        layout = "za";
        variant = "";
      };
    };
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    avahi.enable = false;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    fwupd.enable = true;
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
  };

  hardware.bluetooth.enable = true;

  programs = {
    virt-manager.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    steam = {
      enable = true;
      extraPackages = with pkgs; [javaPackages.compiler.openjdk21];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };

  qt = {
    enable = true;
    style = "adwaita-dark";
  };

  security.rtkit.enable = true;

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

  users.users."${username}".extraGroups = ["networkmanager" "libvirtd" "kvm"];

  hardware.cpu.intel.updateMicrocode = true;

  environment.systemPackages = with pkgs; [
    (
      pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        accent = "rosewater";
        font = "Inter";
        fontSize = "9";
        loginBackground = true;
      }
    )
    weston
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

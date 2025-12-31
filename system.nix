{
  pkgs,
  stateVersion,
  ...
}: {
  imports = [./hardware.nix];

  networking = {
    hostName = "prawnsuit";
    networkmanager.enable = true;
    firewall.trustedInterfaces = ["virbr0"];
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices."luks-358340e8-1746-4f95-bc86-754edf01f663".device = "/dev/disk/by-uuid/358340e8-1746-4f95-bc86-754edf01f663";
  };

  system.stateVersion = stateVersion;

  services = {
    pcscd.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;
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
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        TLP_AUTO_SWITCH = 1;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wwan";
        DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
        PCIE_ASPM_ON_AC = "performance";
        PCIE_ASPM_ON_BAT = "powersave";
      };
    };
    fwupd.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      git
      home-manager
      pinentry-all
      openssh
      xclip
      fuse3
    ];
    sessionVariables = {
      NH_FLAKE = "/home/ethan/repos/nixos-config";
    };
    gnome.excludePackages = with pkgs; [
      gnome-contacts
      gnome-weather
      gnome-clocks
      gnome-maps
      gnome-characters
      gnome-terminal
      gnome-tour
      gnome-connections
      gnome-font-viewer
      gnome-system-monitor
      gnome-logs
      gnome-text-editor
      gnome-calendar
      gnome-music
      gnome-console
      snapshot
      epiphany
      geary
      seahorse
      simple-scan
      yelp
      papers
    ];
  };

  programs = {
    nix-ld.enable = true;
    gnupg.agent.enable = true;
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "Tues 10:00";
      };
    };
    virt-manager.enable = true;
    fish.enable = true;
  };

  nix = {
    nixPath = ["nixpkgs=${pkgs.path}"];
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["ethan"];
    };
    optimise = {
      automatic = true;
      dates = ["Tues 10:00"];
    };
  };

  i18n = {
    defaultLocale = "en_ZA.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_ZA.UTF-8";
      LC_IDENTIFICATION = "en_ZA.UTF-8";
      LC_MEASUREMENT = "en_ZA.UTF-8";
      LC_MONETARY = "en_ZA.UTF-8";
      LC_NAME = "en_ZA.UTF-8";
      LC_NUMERIC = "en_ZA.UTF-8";
      LC_PAPER = "en_ZA.UTF-8";
      LC_TELEPHONE = "en_ZA.UTF-8";
      LC_TIME = "en_ZA.UTF-8";
    };
  };

  time.timeZone = "Africa/Johannesburg";

  nixpkgs.config.allowUnfree = true;

  qt = {
    enable = true;
    platformTheme = "gnome";
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

  users.users."ethan" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "libvirtd" "kvm"];
    shell = pkgs.fish;
  };

  hardware.cpu.intel.updateMicrocode = true;
}

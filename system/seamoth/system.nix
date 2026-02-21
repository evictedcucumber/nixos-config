{
  pkgs,
  username,
  helium-browser,
  ...
}: {
  imports = [./hardware.nix ../../system];

  networking = {
    hostName = "seamoth";
    networkmanager.enable = true;
    firewall.trustedInterfaces = ["virbr0"];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices."luks-358340e8-1746-4f95-bc86-754edf01f663".device = "/dev/disk/by-uuid/358340e8-1746-4f95-bc86-754edf01f663";
  };

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
    gnome.excludePackages = with pkgs; [
      epiphany
      geary
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-system-monitor
      gnome-terminal
      gnome-text-editor
      gnome-tour
      gnome-weather
      papers
      seahorse
      simple-scan
      snapshot
      yelp
    ];
  };

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

  users.users."${username}".extraGroups = ["networkmanager" "libvirtd" "kvm"];

  hardware.cpu.intel.updateMicrocode = true;

  home-manager = {
    extraSpecialArgs = {
      inherit helium-browser;
    };
    users.${username} = {
      imports = [
        ../../home/modules/cli
        ../../home/modules/tui
        ../../home/modules/gui
      ];
    };
  };
}

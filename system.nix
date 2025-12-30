{
  pkgs,
  stateVersion,
  ...
}: {
  imports = [./hardware.nix];

  networking.hostName = "prawnsuit";

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  system.stateVersion = stateVersion;

  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    git
    home-manager
    pinentry-all
    openssh
    xclip
  ];

  environment.sessionVariables = {
    NH_FLAKE = "/home/ethan/repos/nixos-config";
  };
  programs.nix-ld.enable = true;
  programs.gnupg.agent.enable = true;
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "Tues 10:00";
    };
  };

  nix.nixPath = ["nixpkgs=${pkgs.path}"];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  nix.optimise = {
    automatic = true;
    dates = ["Tues 10:00"];
  };

  i18n.defaultLocale = "en_ZA.UTF-8";
  i18n.extraLocaleSettings = {
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

  time.timeZone = "Africa/Johannesburg";

  nixpkgs.config.allowUnfree = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices."luks-358340e8-1746-4f95-bc86-754edf01f663".device = "/dev/disk/by-uuid/358340e8-1746-4f95-bc86-754edf01f663";
  };

  networking.networkmanager.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
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
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  services.xserver = {
    enable = true;
    excludePackages = [pkgs.xterm];
    xkb = {
      layout = "za";
      variant = "";
    };
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
  networking.firewall.trustedInterfaces = ["virbr0"];
  programs.virt-manager.enable = true;

  programs.fish.enable = true;
  users.users."ethan" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "libvirtd" "kvm"];
    shell = pkgs.fish;
  };
  nix.settings.trusted-users = ["ethan"];

  services.avahi.enable = false;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp = {
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

  services.fwupd.enable = true;

  hardware.cpu.intel.updateMicrocode = true;
}

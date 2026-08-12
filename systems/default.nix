{
  pkgs,
  hostname,
  username,
  stateVersion,
  ...
}: {
  # :: BOOT {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # :: }

  # :: SYSTEM {
  system.stateVersion = stateVersion;
  # :: }

  # :: NIX {
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      extra-substituters = ["https://nix-community.cachix.org"];
      extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
      trusted-users = [username];
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = ["Tue 10:00"];
      options = "--delete-older-than 14d";
    };
    optimise = {
      automatic = true;
      dates = ["Tue 10:00"];
    };
  };
  # :: }

  # :: NETWORKING {
  networking.hostName = hostname;
  # :: }

  # :: SECURITY {
  security = {
    sudo.enable = true;
    rtkit.enable = true;
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (action.id == "org.debian.pcsc-lite.access_pcsc" &&
              subject.isInGroup("plugdev")) {
            return polkit.Result.YES;
          }
        });
      '';
    };
    pam.services.login.enableGnomeKeyring = true;
  };
  # :: }

  # :: SERVICES {
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "za";
        variant = "";
      };
    };
    fwupd.enable = true;
    fstrim.enable = true;
    gnome.gnome-keyring.enable = true;
    pcscd.enable = true;
    udev = {
      enable = true;
      packages = with pkgs; [yubikey-personalization libu2f-host];
      extraRules = ''
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0407", KERNEL=="hidraw*", MODE="0666", TAG+="uaccess"
      '';
    };
  };
  # :: }

  # :: LOCALE {
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
  # :: };

  # :: TIME {
  time.timeZone = "Africa/Johannesburg";
  # :: }

  # :: USERS {
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel" "plugdev"];
    shell = pkgs.fish;
  };
  # :: }

  # :: ENVIRONMENT {
  environment.systemPackages = with pkgs; [
    grub2
    kmod
    libfido2
    libsecret
    pcsc-tools
    usbutils
    vim
    yubikey-manager
    yubikey-personalization
  ];
  # :: }

  # :: PROGRAMS {
  programs = {
    nix-ld.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
    fish.enable = true;
  };
  # :: }
}

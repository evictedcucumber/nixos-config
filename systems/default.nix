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
    polkit.enable = true;
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
    extraGroups = ["wheel"];
    shell = pkgs.fish;
  };
  # :: }

  # :: ENVIRONMENT {
  environment.systemPackages = with pkgs; [libsecret];
  # :: }

  # :: PROGRAMS {
  programs = {
    nix-ld.enable = true;
    gnupg.agent.enable = true;
    fish.enable = true;
  };
  # :: }
}

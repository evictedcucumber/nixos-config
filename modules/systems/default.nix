{self, ...}: {
  flake.nixosModules.sharedSystemConfiguration = {
    pkgs,
    username,
    hostConfig,
    ...
  }: {
    imports = [
      self.nixosModules.nixpkgsConfiguration
      self.nixosModules.sharedHomeConfiguration
    ];

    # :: NETWORKING {
    networking.hostName = hostConfig.hostName;
    # :: }

    # :: BOOT {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    # :: }

    # :: FONT {
    fonts.packages = with pkgs; [
      inter
      nerd-fonts.jetbrains-mono
    ];
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

    # :: NIX {
    nix = {
      package = pkgs.nixVersions.latest;
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        extra-substituters = [
          "https://hyprland.cachix.org"
          "https://nix-community.cachix.org"
          "https://noctalia.cachix.org"
          "https://yazi.cachix.org"
        ];
        extra-trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        ];
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

    # :: SECURITY {
    security = {
      sudo.enable = true;
      rtkit.enable = true;
    };
    # :: }

    # :: SERVICES {
    services = {
      xserver = {
        enable = true;
        excludePackages = [pkgs.xterm];
        xkb = {
          layout = "za";
          variant = "";
        };
      };
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
      fwupd.enable = true;
      fstrim.enable = true;
    };
    # :: }

    # :: SYSTEM {
    system.stateVersion = "26.05";
    # :: }

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
    environment.systemPackages = with pkgs; [pinentry-all];
    # :: }

    # :: PROGRAMS {
    programs = {
      nix-ld.enable = true;
      gnupg.agent.enable = true;
      fish.enable = true;
      appimage = {
        enable = true;
        binfmt = true;
      };
    };
    # :: }
  };
}

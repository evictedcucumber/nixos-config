{
  pkgs,
  stateVersion,
  ...
}: {
  system.stateVersion = stateVersion;

  environment = {
    systemPackages = with pkgs; [
      git
      git-lfs
      home-manager
      ncdu
      openssh
      pinentry-all
      xclip
      gnome-extension-manager
      wezterm
    ];
    sessionVariables = {
      NH_FLAKE = "/home/ethan/repos/nixos-config";
    };
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
    fish.enable = true;
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      extra-substituters = [
        "https://yazi.cachix.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
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
}

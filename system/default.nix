{
  pkgs,
  config,
  stateVersion,
  username,
  neovim-config,
  ...
}: {
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.fish;
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
      trusted-users = [username];
    };
    optimise = {
      automatic = true;
      dates = ["Tues 10:00"];
    };
  };

  system.stateVersion = stateVersion;

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  environment = {
    systemPackages = with pkgs; [
      git
      git-lfs
      ncdu
      openssh
      pinentry-all
      xclip
      gnome-extension-manager
      wezterm
      inter
      nerd-fonts.jetbrains-mono
    ];
    sessionVariables.NH_FLAKE = "/home/ethan/repos/nixos-config";
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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit neovim-config;
    };

    users.${username} = let
      configHome = config.home-manager.users.${username};
    in {
      home = {
        inherit username stateVersion;
        homeDirectory = "/home/${username}";
      };

      xdg = {
        enable = true;
        configHome = "${configHome.home.homeDirectory}/.config";
        dataHome = "${configHome.home.homeDirectory}/.local/share";
        stateHome = "${configHome.home.homeDirectory}/.local/state";
        cacheHome = "${configHome.home.homeDirectory}/.local/cache";
      };
    };
  };
}

{
  pkgs,
  hostname,
  stateVersion,
  username,
  ...
}: {
  networking.hostName = "${hostname}";

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
    NH_FLAKE = "/home/${username}/repos/nixos-config";
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
}

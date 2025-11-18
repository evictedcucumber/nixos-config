{
  pkgs,
  hostname,
  stateVersion,
  username,
  ...
}: {
  networking.hostName = "${hostname}";

  boot.kernelPackages = pkgs.linuxPackages_6_12;

  system.stateVersion = stateVersion;

  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    git
    home-manager
    pinentry-all
    openssh
    xclip
  ];

  programs.nix-ld.enable = true;
  programs.gnupg.agent.enable = true;
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "Tues 10:00";
    };
    flake = "/home/${username}/repos/nixos-config";
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

}

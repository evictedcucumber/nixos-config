{
  pkgs,
  hostname,
  stateVersion,
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

  nix.nixPath = ["nixpkgs=${pkgs.path}"];
  nix.settings.experimental-features = ["nix-command" "flakes"];
}

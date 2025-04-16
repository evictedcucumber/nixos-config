{
  pkgs,
  hostname,
  ...
}: {
  networking.hostName = "${hostname}";

  boot.kernelPackages = pkgs.linuxPackages_6_12;

  system.stateVersion = "24.11";

  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    git
    home-manager
    pinentry-all
    openssh
    xclip
  ];

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.gnupg.agent.enable = true;

  nix.nixPath = ["nixpkgs=${pkgs.path}"];
  nix.settings.experimental-features = ["nix-command" "flakes"];
}

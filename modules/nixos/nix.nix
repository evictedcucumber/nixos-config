{pkgs, ...}: {
  # :: NIX {
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      extra-substituters = ["https://nix-community.cachix.org"];
      extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = ["Tue 10:30"];
      options = "--delete-older-than 14d";
    };
  };
  # :: }

  # :: PROGRAMS {
  programs.nix-ld.enable = true;
  # :: }
}

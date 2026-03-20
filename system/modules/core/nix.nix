{
  username,
  lib,
  config,
  ...
}: {
  options.me.system.core.nix.enable = lib.mkEnableOption "Enable Nix Options";

  config = lib.mkIf config.me.system.core.nix.enable {
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        extra-substituters = [
          "https://yazi.cachix.org"
          "https://nix-community.cachix.org"
          "https://hyprland.cachix.org"
        ];
        extra-trusted-public-keys = [
          "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
        trusted-users = [username];
      };
      optimise = {
        automatic = true;
        dates = ["Tues 10:00"];
      };
    };
  };
}

# Settings every host's home shares. Hosts pick their profiles in hosts/<host>/home.nix.
{
  lib,
  config,
  osConfig,
  username,
  ...
}: {
  options.me.flakePath = lib.mkOption {
    type = lib.types.str;
    default = "${config.home.homeDirectory}/repos/nixos-config";
    description = "Where this repo is cloned. Dotfiles under config/ are symlinked from here.";
  };

  config = {
    home = {
      inherit username;
      inherit (osConfig.system) stateVersion;
      homeDirectory = "/home/${username}";

      activation.mePathCheckFlake = import ../../lib/mkPathCheck.nix {inherit lib config;} {
        option = "me.flakePath";
        path = "${config.me.flakePath}/flake.nix";
      };
    };

    xdg = {
      enable = true;
      configHome = "${config.home.homeDirectory}/.config";
      dataHome = "${config.home.homeDirectory}/.local/share";
      stateHome = "${config.home.homeDirectory}/.local/state";
    };
  };
}

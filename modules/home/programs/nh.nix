{config, ...}: {
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/repos/nixos-config";
  };
}

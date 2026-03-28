{username, ...}: {
  flake.homeModules.nh = {pkgs, ...}: {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "Tue 10:00";
      };
      flake = "/home/${username}/repos/nixos-config";
      package = pkgs.nh;
    };
  };
}

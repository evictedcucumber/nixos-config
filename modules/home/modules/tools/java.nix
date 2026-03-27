{...}: {
  flake.homeModules.java = {pkgs, ...}: {
    programs.java = {
      enable = true;
      package = pkgs.jdk25;
    };
  };
}

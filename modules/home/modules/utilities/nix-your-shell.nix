{...}: {
  flake.homeModules.nix-your-shell = {...}: {
    programs.nix-your-shell = {
      enable = true;
      nix-output-monitor.enable = true;
    };
  };
}

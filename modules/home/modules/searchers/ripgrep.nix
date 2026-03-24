{...}: {
  flake.homeModules.ripgrep = {...}: {
    programs.ripgrep = {
      enable = true;
      arguments = ["--color=always"];
    };
  };
}

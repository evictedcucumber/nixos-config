{...}: {
  flake.homeModules.ghostty = {pkgs, ...}: {
    programs.ghostty = {
      enable = true;
      package = pkgs.ghostty;
      settings = {
        theme = "Rose Pine";
        font-family = "JetBrainsMono Nerd Font";
        cursor-style-blink = false;
        maximize = true;
        window-decoration = "none";
        window-padding-x = 4;
        window-padding-y = 2;
      };
    };
  };
}

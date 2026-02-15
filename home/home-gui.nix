{
  pkgs,
  helium-browser,
  ...
}: {
  home.packages = with pkgs; [
    brave
    obsidian
    helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "Catppuccin Mocha";
      font-family = "JetBrainsMono Nerd Font";
      cursor-style-blink = false;
      maximize = true;
      window-decoration = "none";
      window-padding-x = 4;
      window-padding-y = 2;
    };
  };
}

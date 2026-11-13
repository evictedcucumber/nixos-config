{
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    package = inputs.ghostty-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
}

{self, ...}: {
  flake.homeModules.yazi = {pkgs, ...}: {
    imports = with self.homeModules; [
      bat
      fd
      fzf
      jq
      ripgrep
      zoxide
    ];
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      package = pkgs.yazi;
    };

    home.packages = with pkgs; [
      ffmpeg
      p7zip
      poppler
      file
      resvg
      imagemagick
      xclip
      wl-clipboard
      xsel
    ];
  };
}

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
      settings.mgr.show_hidden = true;
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

    xdg.configFile."yazi/flavors".source = ../../../../config/files/yazi/flavors;
    xdg.configFile."yazi/theme.toml".source = ../../../../config/files/yazi/theme.toml;
  };
}

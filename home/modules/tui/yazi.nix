{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../cli/bat.nix
    ../cli/fzf.nix
    ../cli/ripgrep.nix
    ../cli/zoxide.nix
  ];

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    plugins = {
      gvfs = pkgs.gvfs;
    };
  };

  programs.jq.enable = true;
  programs.fd.enable = true;

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
}

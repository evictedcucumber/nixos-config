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

  xdg.configFile."yazi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/nixos-config/config/yazi";
}

{
  pkgs,
  username,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      git
      git-lfs
      ncdu
      openssh
      pinentry-all
      xclip
      wezterm
    ];
    sessionVariables.NH_FLAKE = "/home/${username}/repos/nixos-config";
  };
}

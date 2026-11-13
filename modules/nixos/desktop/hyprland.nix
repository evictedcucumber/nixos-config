# Hyprland under UWSM, started from greetd.
{
  config,
  pkgs,
  ...
}: {
  # :: NIX {
  nix.settings = {
    extra-substituters = ["https://noctalia.cachix.org"];
    extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
  };
  # :: }

  # :: SECURITY {
  security.pam.services.greetd.enableGnomeKeyring = true;
  # :: }

  # :: SERVICES {
  services = {
    displayManager = {
      gdm.enable = false;
      sddm.enable = false;
    };
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd '${config.programs.uwsm.package}/bin/uwsm start hyprland-uwsm.desktop'";
          user = "greeter";
        };
      };
    };
  };
  # :: }

  # :: ENVIRONMENT {
  environment.systemPackages = with pkgs; [
    wl-clipboard
    wl-clipboard-x11
  ];
  # :: }

  # :: PROGRAMS {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
  # :: }
}

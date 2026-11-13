# Hyprland under UWSM, started from greetd.
{
  config,
  pkgs,
  ...
}: {
  # :: SECURITY {
  security.pam.services.greetd.enableGnomeKeyring = true;
  # :: }

  # :: SERVICES {
  services = {
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

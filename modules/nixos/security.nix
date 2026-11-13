# sudo, polkit, the GNOME keyring, GnuPG, and YubiKey/FIDO2 support.
{
  lib,
  pkgs,
  username,
  ...
}: {
  # :: SECURITY {
  security = {
    sudo.enable = true;
    rtkit.enable = true;
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (action.id == "org.debian.pcsc-lite.access_pcsc" &&
              subject.isInGroup("plugdev")) {
            return polkit.Result.YES;
          }
        });
      '';
    };
    pam.services.login.enableGnomeKeyring = true;
  };
  # :: }

  # :: SERVICES {
  services = {
    gnome = {
      gnome-keyring.enable = true;
      # SSH keys are FIDO2 (sk) keys served by home-manager's ssh-agent;
      # keep gcr from claiming SSH_AUTH_SOCK as a second agent.
      gcr-ssh-agent.enable = false;
    };
    pcscd.enable = true;
    udev = {
      enable = true;
      packages = with pkgs; [yubikey-personalization libu2f-host];
      # uaccess only grants ACLs to a seat session; WSL logins have no seat,
      # so also grant the plugdev group directly or FIDO2 ssh can't open hidraw.
      extraRules = ''
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0407", KERNEL=="hidraw*", GROUP="plugdev", MODE="0660", TAG+="uaccess"
      '';
    };
  };
  # :: }

  # :: USERS {
  users = {
    groups.plugdev = {};
    users.${username}.extraGroups = ["plugdev"];
  };
  # :: }

  # :: ENVIRONMENT {
  environment.systemPackages = with pkgs; [
    libfido2
    libsecret
    pcsc-tools
    yubikey-manager
    yubikey-personalization
  ];
  # :: }

  # :: PROGRAMS {
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = lib.mkDefault pkgs.pinentry-curses;
  };
  # :: }
}

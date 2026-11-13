# Power profiles that follow AC and battery state.
{pkgs, ...}: {
  # :: SERVICES {
  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
    udev.extraRules = let
      ppd = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl";
      sysrun = "${pkgs.systemd}/bin/systemd-run";
    in ''
      # Plugged in → performance
      SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", \
        RUN+="${sysrun} --no-block ${ppd} set performance"

      # Unplugged → balanced
      SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", \
        RUN+="${sysrun} --no-block ${ppd} set balanced"
    '';
  };
  # :: }

  # :: SYSTEMD {
  systemd = {
    # Battery ≤15% while discharging → power-saver. Polled instead of
    # matched via udev, since udev can only match an exact capacity value
    # and would silently never fire if a reading skips past 15% (e.g.
    # after resume).
    services.battery-power-saver = {
      description = "Switch to power-saver profile when battery is low";
      path = [pkgs.coreutils pkgs.power-profiles-daemon];
      serviceConfig.Type = "oneshot";
      script = ''
        for bat in /sys/class/power_supply/BAT*; do
          [ -e "$bat/status" ] || continue
          [ -e "$bat/capacity" ] || continue
          status=$(cat "$bat/status")
          capacity=$(cat "$bat/capacity")
          if [ "$status" = "Discharging" ] && [ "$capacity" -le 15 ]; then
            powerprofilesctl set power-saver
          fi
        done
      '';
    };

    timers.battery-power-saver = {
      description = "Periodically check battery level for power-saver switch";
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "1min";
        OnUnitActiveSec = "1min";
      };
    };
  };
  # :: }
}

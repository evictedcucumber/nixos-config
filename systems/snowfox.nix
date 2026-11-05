{username, ...}: {
  imports = [./wsl.nix];

  # :: NIX {
  # WSL has no KVM on some Windows builds, so homelab tests run in nspawn, which needs uid-range.
  nix.settings = {
    experimental-features = ["auto-allocate-uids"];
    auto-allocate-uids = true;
    system-features = ["uid-range"];
  };
  # :: }

  # :: SYSTEMD {
  # FIX: Disabled due to issues installing obsidian-headless
  # systemd.user.services."vault-sync" = {
  #   description = "Continuous sync obsidian vault.";
  #   after = ["default.target"];
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "/bin/bash -lc '/home/${username}/.npm-global/bin/ob sync --path /home/${username}/myvault --continuous'";
  #     Restart = "always";
  #     RestartSec = 5;
  #   };
  #   wantedBy = ["default.target"];
  # };
  # :: }

  # :: HOME {
  home-manager.users.${username} = import ../home/snowfox.nix;
  # :: }
}

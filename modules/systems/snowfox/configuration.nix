{
  inputs,
  username,
  ...
}: {
  flake.nixosModules.snowfoxConfiguration = {pkgs, ...}: {
    imports = [inputs.nixos-wsl.nixosModules.default];

    # :: WSL {
    wsl = {
      enable = true;
      wslConf.interop.appendWindowsPath = false;
      defaultUser = "${username}";
      interop.register = true;
    };
    # :: }

    # :: SYSTEMD {
    systemd.user.services."vault-sync" = {
      description = "Continuous sync obsidian vault.";
      after = ["default.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "/bin/bash -lc '/home/${username}/.npm-global/bin/ob sync --path /home/${username}/myvault --continuous'";
        Restart = "always";
        RestartSec = 5;
      };
      wantedBy = ["default.target"];
    };
    # :: }

    # :: ENVIRONMENT {
    environment.systemPackages = with pkgs; [xclip xsel];
    # :: }
  };
}

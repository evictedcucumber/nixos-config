{
  config,
  username,
  ...
}: {
  imports = [../../system];

  networking.hostName = "snowfox";

  wsl.enable = true;
  wsl.wslConf.interop.appendWindowsPath = false;
  wsl.defaultUser = username;

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

  home-manager.users.${username} = {
    imports = [
      ../../home/modules/cli
      ../../home/modules/tui
    ];

    me.cli.git.signingkey = "A2FD5AF74494FD44";

    home.sessionVariables = let
      configHome = config.home-manager.users.${username}.home.sessionVariables;
    in {
      LEDGERS_DIR = "/home/${username}/myvault/97 - Finance";
      LEDGER_FILE = "${configHome.LEDGERS_DIR}/main.journal";
      CURRENT_LEDGER_FILE = "${configHome.LEDGERS_DIR}/current.journal";
      YEAR_LEDGER_FILE = "${configHome.LEDGERS_DIR}/2026.journal";
    };
  };
}

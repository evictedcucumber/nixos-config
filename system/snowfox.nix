{
  config,
  username,
  ...
}: {
  me.system.core.networking.hostName = "snowfox";

  # WSL Config
  wsl = {
    enable = true;
    wslConf.interop.appendWindowsPath = false;
    defaultUser = username;
  };

  # SystemD Units
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
      ../home/modules/cli
      ../home/modules/tui
    ];

    home.sessionVariables = let
      configHome = config.home-manager.users.${username}.home.sessionVariables;
    in {
      LEDGERS_DIR = "/home/${username}/myvault/97 - Finance";
      LEDGER_FILE = "${configHome.LEDGERS_DIR}/main.journal";
      CURRENT_LEDGER_FILE = "${configHome.LEDGERS_DIR}/current.journal";
      YEAR_LEDGER_FILE = "${configHome.LEDGERS_DIR}/2026.journal";
    };

    me.home.cli = {
      git = {
        enable = true;
        signingkey = "A2FD5AF74494FD44";
      };
      bat.enable = true;
      direnv.enable = true;
      fzf.enable = true;
      nix-your-shell.enable = true;
      nodejs.enable = true;
      ripgrep.enable = true;
      starship.enable = true;
      tealdeer.enable = true;
      zoxide.enable = true;
    };
  };
}

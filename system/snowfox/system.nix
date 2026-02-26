{username, ...}: {
  imports = [../../system];

  networking.hostName = "snowfox";

  wsl.enable = true;
  wsl.wslConf.interop.appendWindowsPath = false;
  wsl.defaultUser = username;

  home-manager.users.${username} = {
    imports = [
      ../../home/modules/cli
      ../../home/modules/tui
    ];

    me.cli.git.signingkey = "A2FD5AF74494FD44";

    home.sessionVariables = {
      LEDGER_FILE = "/mnt/c/Users/ethan/Documents/My Obsidian Vault/99 - Meta/hledger.journal";
    };
  };
}

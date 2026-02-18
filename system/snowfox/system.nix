{
  pkgs,
  username,
  neovim-config,
  ...
}: {
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
  };
}

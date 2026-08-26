{...}: {
  imports = [./default.nix];

  # :: ME {
  # Delta on top of the common profile in ./default.nix.
  me.tools.ssh.extraConfig = {
    "vs-ssh.visualstudio.com" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/sb.key";
      forwardAgent = true;
      kbdInteractiveAuthentication = "yes";
      passwordAuthentication = "no";
    };
  };
  # :: }
}

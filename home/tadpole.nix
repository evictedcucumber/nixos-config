{pkgs, ...}: {
  imports = [./default.nix];

  # :: PACKAGES {
  home.packages = [pkgs.uv];
  # :: }

  # :: ME {
  # Delta on top of the common profile in ./default.nix.
  me.tools.ssh.extraConfig = {
    "vs-ssh.visualstudio.com" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/sb.key";
      kbdInteractiveAuthentication = "yes";
      passwordAuthentication = "no";
    };
  };
  # :: }
}

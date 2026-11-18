{pkgs, ...}: {
  imports = [../../modules/home/profiles/dev.nix];

  # :: PACKAGES {
  home.packages = with pkgs; [uv azure-cli];
  # :: }

  # :: ME {
  me.ssh.extraConfig = {
    "vs-ssh.visualstudio.com" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/sb.key";
      kbdInteractiveAuthentication = "yes";
      passwordAuthentication = "no";
    };
  };
  # :: }
}

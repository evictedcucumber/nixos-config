{pkgs, ...}: {
  imports = [./default.nix];

  # :: PACKAGES {
  home.packages = with pkgs; [uv azure-cli];
  # :: }

  # :: SESSION VARIABLES {
  home.sessionVariables.LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc}/lib";
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

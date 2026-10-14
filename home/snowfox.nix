{...}: {
  imports = [./default.nix];

  # :: ME {
  # Delta on top of the common profile in ./default.nix.
  me.tools = {
    git.settings.signingKey = "440DB3144C3649BA";
    ssh.extraConfig = {
      "tcyclops.homelab.zezura.cc" = {
        hostName = "10.0.0.2";
        identitiesOnly = "yes";
        identityFile = "~/.ssh/ansible-control-node.key";
        user = "root";
      };
    };
  };
  # :: }
}

_: {
  imports = [../../modules/home/profiles/dev.nix];

  # :: ME {
  me = {
    git.signingKey = "440DB3144C3649BA";
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

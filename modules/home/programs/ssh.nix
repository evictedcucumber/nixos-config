{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.ssh.extraConfig = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "Extra settings added to programs.ssh.settings.";
  };

  config = {
    programs.ssh = {
      enable = true;
      package = pkgs.openssh;
      enableDefaultConfig = false;
      settings =
        lib.recursiveUpdate {
          "github.com" = {
            identityFile = "~/.ssh/github_primary_sk.key";
            hostName = "github.com";
            user = "git";
            identitiesOnly = "yes";
            controlMaster = "auto";
            controlPersist = "10m";
          };
          "*" = {
            forwardAgent = false;
            addKeysToAgent = "no";
            compression = false;
            serverAliveInterval = 0;
            serverAliveCountMax = 3;
            hashKnownHosts = false;
            userKnownHostsFile = "~/.ssh/known_hosts";
            controlMaster = "no";
            controlPath = "~/.ssh/master-%r@%n:%p";
            controlPersist = "no";
          };
        }
        config.me.ssh.extraConfig;
    };

    services.ssh-agent.enable = true;
  };
}

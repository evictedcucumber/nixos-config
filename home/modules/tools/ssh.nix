{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.tools.ssh = {
    enable = lib.mkEnableOption "Enable SSH Config";
    hasGithubKey = lib.mkEnableOption "Enable Github Key";
    extraConfig = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Extra settings added to programs.ssh.settings.";
    };
  };

  config = lib.mkIf config.me.tools.ssh.enable {
    programs.ssh = {
      enable = true;
      package = pkgs.openssh;
      enableDefaultConfig = false;
      settings =
        lib.recursiveUpdate {
          "github.com" = lib.mkIf config.me.tools.ssh.hasGithubKey {
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
        config.me.tools.ssh.extraConfig;
    };

    services.ssh-agent.enable = true;
  };
}

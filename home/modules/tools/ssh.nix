{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.tools.ssh = {
    enable = lib.mkEnableOption "Enable SSH Config";
    hasGithubKey = lib.mkEnableOption "Enable Github Key";
  };

  config = lib.mkIf config.me.tools.ssh.enable {
    programs.ssh = {
      enable = true;
      package = pkgs.openssh;
      enableDefaultConfig = false;
      settings = {
        "github.com" = lib.mkIf config.me.tools.ssh.hasGithubKey {
          addKeysToAgent = "yes";
          identityFile = "~/.ssh/github_key";
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
      };
    };

    services.ssh-agent.enable = true;
  };
}

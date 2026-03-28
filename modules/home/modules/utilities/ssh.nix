{...}: {
  flake.homeModules.ssh = {pkgs, ...}: {
    programs.ssh = {
      enable = true;
      package = pkgs.openssh;
      enableDefaultConfig = false;
      matchBlocks = {
        "github.com" = {
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

    services.ssh-agent = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}

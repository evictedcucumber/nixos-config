{...}: {
  flake.homeModules.git = {homeConfig, ...}: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Ethan";
          email = "95688781+evictedcucumber@users.noreply.github.com";
          signingkey = homeConfig.gitSigningKey;
        };
        init.defaultbranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        rebase.updaterefs = true;
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
        };
        commit = {
          verbose = true;
          gpgsign = true;
        };
        column.ui = "auto";
        rerere = {
          enabled = true;
          autoupdate = true;
        };
        tag.gpgSign = true;
      };
    };
  };
}

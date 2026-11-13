{
  lib,
  config,
  ...
}: {
  options.me.git.signingKey = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "GPG key to sign commits and tags with.";
  };

  config = {
    programs.git = {
      enable = true;
      settings = lib.mkMerge [
        {
          user = {
            name = "Ethan";
            email = "95688781+evictedcucumber@users.noreply.github.com";
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
          commit.verbose = true;
          column.ui = "auto";
          rerere = {
            enabled = true;
            autoupdate = true;
          };
        }
        (lib.mkIf (config.me.git.signingKey != null) {
          user.signingkey = config.me.git.signingKey;
          commit.gpgsign = true;
          tag.gpgSign = true;
        })
      ];
    };

    programs.gh.enable = true;
  };
}

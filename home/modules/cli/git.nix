{
  config,
  lib,
  ...
}: {
  options.me.cli.git.signingkey = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "The signing key used by Git";
  };

  config = {
    programs.git = {
      enable = true;
      settings =
        lib.recursiveUpdate {
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
        } (
          if config.me.cli.git.signingkey != ""
          then {
            user.signingkey = config.me.cli.git.signingkey;
            commit.gpgsign = true;
            tag.gpgSign = true;
          }
          else {}
        );
    };
  };
}

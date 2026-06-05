{
  lib,
  config,
  ...
}: {
  options.me.tools.git = {
    enable = lib.mkEnableOption "Enable Git";
    settings = {
      user = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "Ethan";
          description = "Set Git Username";
        };
        email = lib.mkOption {
          type = lib.types.str;
          default = "95688781+evictedcucumber@users.noreply.github.com";
          description = "Set Git User Email";
        };
      };
      signingKey = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Set Git Signing GPG Key";
      };
    };
  };

  config = lib.mkIf config.me.tools.git.enable {
    programs.git = {
      enable = true;
      settings = lib.mkMerge [
        {
          user = {
            name = config.me.tools.git.settings.user.name;
            email = config.me.tools.git.settings.user.email;
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
        (lib.mkIf (config.me.tools.git.settings.signingKey != null) {
          user.signingkey = config.me.tools.git.settings.signingKey;
          commit.gpgsign = true;
          tag.gpgSign = true;
        })
      ];
    };

    programs.gh.enable = true;
  };
}

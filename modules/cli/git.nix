{
  lib,
  config,
  ...
}: {
  options.me.cli.git = {
    enable = lib.mkEnableOption "Enable GIT";
    gpgKey = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The short string representation of the gpg key used to sign commits";
    };
  };

  config = lib.mkIf config.me.cli.git.enable {
    programs.git = {
      enable = true;
      userName = "Ethan";
      userEmail = "95688781+evictedcucumber@users.noreply.github.com";
      extraConfig =
        {
          init.defaultbranch = "main";
          pull.rebase = true;
          rebase.updaterefs = true;
        }
        // (lib.mkIf (config.me.cli.git.gpgKey != "") {
          user.signingkey = "${config.me.cli.git.gpgKey}";
          commit.gpgsign = true;
          tag.gpgSign = true;
        });
    };
  };
}

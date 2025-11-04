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
      settings = {
        user = {
          name = "Ethan";
          email = "95688781+evictedcucumber@users.noreply.github.com";
          signingkey = lib.mkIf (config.me.cli.git.gpgKey != "") "${config.me.cli.git.gpgKey}";
        };
        init.defaultbranch = "main";
        pull.rebase = true;
        rebase.updaterefs = true;
        commit.gpgsign = lib.mkIf (config.me.cli.git.gpgKey != "") true;
        tag.gpgSign = lib.mkIf (config.me.cli.git.gpgKey != "") true;
      };
    };
  };
}

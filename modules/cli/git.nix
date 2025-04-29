{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {me.cli.git.enable = lib.mkEnableOption "Enable GIT";};

  config = lib.mkIf config.me.cli.git.enable {
    programs.git.enable = true;
    programs.git.userName = "Ethan";
    programs.git.userEmail = "95688781+evictedcucumber@users.noreply.github.com";
    programs.git.extraConfig = {
      user.signingkey = "8E29907A4CA30E30";
      init.defaultbranch = "main";
      pull.rebase = true;
      rebase.updaterefs = true;
      commit.gpgsign = true;
      tag.gpgSign = true;
    };

    home.packages = with pkgs; [pre-commit];
  };
}

{
  lib,
  config,
  ...
}: {
  options = {me.cli.shells.bash.enable = lib.mkEnableOption "Enable Bash";};

  config = lib.mkIf config.me.cli.shells.bash.enable {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      historyControl = ["erasedups" "ignoreboth"];
      historyFile = "${config.xdg.stateHome}/bashhistory";
      historyFileSize = 100000;
      historySize = 100000;
      shellAliases = config.me.cli.shells.shellAliases;
      profileExtra = "fastfetch";
      bashrcExtra = ''
        mkcd() {
            if [ -d $1 ]; then
                cd $1
            else
                mkdir -p $1
                cd $1
            fi
        }
      '';
    };
  };
}

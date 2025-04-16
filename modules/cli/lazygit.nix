{
  lib,
  config,
  ...
}: {
  options = {me.cli.lazygit.enable = lib.mkEnableOption "Enable Lazygit";};

  config = lib.mkIf config.me.cli.lazygit.enable {
    programs.lazygit.enable = true;
    programs.lazygit.settings = {
      gui = {
        theme = {
          activeBorderColor = ["#89b4fa" "bold"];
          inactiveBorderColor = ["#a6adc8"];
          optionsTextColor = ["#89b4fa"];
          selectedLineBgColor = ["#313244"];
          cherryPickedCommitBgColor = ["#45475a"];
          cherryPickedCommitFgColor = ["#89b4fa"];
          unstagedChangesColor = ["#f38ba8"];
          defaultFgColor = ["#cdd6f4"];
          searchingActiveBorderColor = ["#f9e2af"];
        };
      };
    };
  };
}

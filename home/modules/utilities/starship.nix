{
  lib,
  config,
  ...
}: {
  options.me.utilities.starship.enable = lib.mkEnableOption "Enable Starship Prompt";

  config = lib.mkIf config.me.utilities.starship.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = config.me.shells.fish.integrations.enable;
      enableTransience = true;
      settings = {
        add_newline = true;
        palette = "rose-pine";
        palettes.rose-pine = {
          overlay = "#26233a";
          love = "#eb6f92";
          gold = "#f6c177";
          rose = "#ebbcba";
          pine = "#31748f";
          foam = "#9ccfd8";
          iris = "#c4a7e7";
        };
        format = ''
          $directory$git_branch$git_status$rust
          $nix_shell$cmd_duration$character
        '';
        directory = {
          truncation_length = 3;
          read_only = "  ";
          fish_style_pwd_dir_length = 1;
        };
        git_status.disabled = false;
        rust = {
          disabled = false;
          symbol = " ";
        };
        cmd_duration.min_time = 5000;
      };
    };
  };
}

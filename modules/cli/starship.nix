{
  config,
  lib,
  ...
}: {
  options = {
    me.cli.starship.enable = lib.mkEnableOption "Enable Starship";
  };

  config = lib.mkIf config.me.cli.starship.enable {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        palette = "catppuccin_mocha";
        palettes.catppuccin_mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
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
        cmd_duration = {
          min_time = 5000;
        };
        nix_shell = {
          format = "via [$symbol$name]($style) ";
        };
      };
    };
  };
}

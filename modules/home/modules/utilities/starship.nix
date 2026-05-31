{...}: {
  flake.homeModules.starship = {...}: {
    programs.starship = {
      enable = true;
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
          format = "[](fg:overlay)[ $path ]($style)[](fg:overlay) ";
          truncation_length = 3;
          read_only = "  ";
          fish_style_pwd_dir_length = 1;
          style = "bg:overlay fg:pine";
        };
        git_branch = {
          format = "[](fg:overlay)[ $symbol $branch ]($style)[](fg:overlay) ";
          style = "bg:overlay fg:foam";
        };
        git_status = {
          disabled = false;
          style = "bg:overlay fg:love";
          format = "[](fg:overlay)([$all_status$ahead_behind]($style))[](fg:overlay) ";
          up_to_date = "[ ✓ ](bg:overlay fg:iris)";
          untracked = "[?\($count\)](bg:overlay fg:gold)";
          stashed = "[$](bg:overlay fg:iris)";
          modified = "[!\($count\)](bg:overlay fg:gold)";
          renamed = "[»\($count\)](bg:overlay fg:iris)";
          deleted = "[✘\($count\)](style)";
          staged = "[++\($count\)](bg:overlay fg:gold)";
          ahead = "[⇡\($${count}\)](bg:overlay fg:foam)";
          diverged = "⇕[\[](bg:overlay fg:iris)[⇡\($${ahead_count}\)](bg:overlay fg:foam)[⇣\($${behind_count}\)](bg:overlay fg:rose)[\]](bg:overlay fg:iris)";
          behind = "[⇣\($${count}\)](bg:overlay fg:rose)";
        };
        rust = {
          disabled = false;
          format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
          style = "bg:overlay fg:pine";
          symbol = " ";
        };
        cmd_duration.min_time = 5000;
        nix_shell.format = "via [$symbol$name]($style) ";
      };
    };
  };
}

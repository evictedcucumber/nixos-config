{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./zsh.nix ./bash.nix];

  options = {
    me.cli.shells.enable = lib.mkEnableOption "Enable Shells";
    me.cli.shells.shellAliases = lib.mkOption {
      description = "Common shell aliases";
      type = lib.types.attrs;
      default = {};
    };
  };

  config = lib.mkIf config.me.cli.shells.enable {
    home.packages = with pkgs; [bat-extras.batman eza fastfetch ripgrep fd];

    home.sessionVariables = {
      BAT_THEME = "catppuccin";
      FZF_DEFAULT_OPTS = ''
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
        --color=selected-bg:#45475a
        --color=border:#313244,label:#cdd6f4
      '';
    };

    programs.bat.enable = true;
    programs.bat.themes = {
      catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "main";
          sha256 = "sha256-6fWoCH90IGumAMc4buLRWL0N61op+AuMNN9CAR9/OdI=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };

    programs.zoxide.enable = true;
    programs.fzf.enable = true;

    me.cli.shells.shellAliases = {
      v = "nvim";
      vv = "NVIM_APPNAME=neovim nvim";
      cat = "bat";
      mkdir = "mkdir -p";
      rg = "rg --color=always";
      grep = "rg";
      ls = "eza -a -F=always --icons=always --group-directories-first --sort=name -1";
      la = "ls -l -h --no-time --group";
      lt = "ls -T -I='.git'";
      "z-" = "z -";
      "z.." = "z ..";
    };

    me.cli.shells.zsh.enable = true;
  };
}

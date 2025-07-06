{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {me.cli.shells.zsh.enable = lib.mkEnableOption "Enable ZSH";};

  config = lib.mkIf config.me.cli.shells.zsh.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      history = {
        append = true;
        extended = true;
        ignoreDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        share = true;
        path = "${config.xdg.stateHome}/zshhistory";
        save = 100000;
        size = 100000;
      };
      defaultKeymap = "emacs";
      shellAliases = {
        v = "NVIM_APPNAME=neovim nvim";
        e = "emacsclient -c -a 'emacs'";
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
      nixdev = "nix develop --command \${SHELL}";
      mux = "tmuxinator";
      autosuggestion = {
        enable = true;
        strategy = ["history" "completion" "match_prev_cmd"];
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = ["main" "brackets" "pattern" "regexp" "cursor" "root" "line"];
      };
      plugins = [
        {
          name = "catppuccin-zsh-syntax-highlighting";
          file = "themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "zsh-syntax-highlighting";
            rev = "main";
            sha256 = "sha256-l6tztApzYpQ2/CiKuLBf8vI2imM6vPJuFdNDSEi7T/o=";
          };
        }
        {
          name = "zsh-completions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-completions";
            rev = "master";
            sha256 = "sha256-9s9EkorKNH1DrA9rKUl/4aGIZY+7+EyryZ/69365te0=";
          };
        }
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "master";
            sha256 = "sha256-q26XVS/LcyZPRqDNwKKA9exgBByE0muyuNb0Bbar2lY=";
          };
        }
      ];
      sessionVariables = {
        TERM = "xterm-256color";
        PATH = "$PATH:$HOME/.cargo/bin";
      };
      initContent = ''
        zstyle :compinstall filename "''${ZDOTDIR}/.zshrc"
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "''${XDG_CACHE_HOME}/zsh/.zcompcache"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf=preview 'ls $realpath'
        zstyle ':fzf-tab:*' switch-group '<' '>'

        setopt correct
        setopt extendedglob
        setopt nocaseglob
        setopt numericglobsort
        setopt nobeep
        setopt hist_find_no_dups
        setopt hist_save_no_dups
        setopt inc_append_history

        eval "$(batman --export-env)"

        mkcd() {
            if [ -d $1 ]; then
                __zoxide_z $1
            else
                mkdir -p $1
                __zoxide_z $1
            fi
        }

        bindkey -r '^f'
        bindkey -s '^f' '^Uyy^M'

        bindkey -r '^k'
        bindkey '^k' up-line-or-search
        bindkey -r '^j'
        bindkey '^j' down-line-or-search

        bindkey -r '^x'
        bindkey '^x' kill-whole-line

        bindkey -r '^e'
        bindkey '^e' autosuggest-accept
      '';
      loginExtra = "fastfetch";
    };
  };
}

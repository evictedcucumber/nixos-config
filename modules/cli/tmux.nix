{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {me.cli.tmux.enable = lib.mkEnableOption "Enable TMUX";};

  config = lib.mkIf config.me.cli.tmux.enable {
    programs.tmux.tmuxinator.enable = true;
    programs.tmux.enable = true;
    programs.tmux = {
      terminal = "screen-256color";
      baseIndex = 1;
      mouse = true;
      prefix = "C-space";
      escapeTime = 0;
      historyLimit = 50000;
      clock24 = true;
      sensibleOnTop = false;
      plugins = [
        {
          plugin = pkgs.tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor "mocha"
            set -g @catppuccin_window_status_style "rounded"
            set -g @catppuccin_window_current_number_color "#{@thm_lavender}"
            set -g @catppuccin_window_current_text " #{window_name}"
            set -g @catppuccin_window_text " #{window_name}"
          '';
        }
      ];
      extraConfig = ''
        set -ag terminal-overrides ",xterm-256color:RGB"

        set -g status-left ""
        set -g status-right ""
        set -g status-justify centre
        set -g detach-on-destroy off
        set -g visual-activity off
        set -g visual-bell off
        set -g visual-silence off
        set -g bell-action none
        set -g set-clipboard on
        set -g status-interval 3
        set -g status-position top
        set -g display-time 4000
        set -g renumber-windows on
        set -g focus-events on

        set -g status-keys emacs
        set -g mode-keys vi

        setw -g monitor-activity off

        unbind %
        bind \\ split-window -h -c "#{pane_current_path}"

        unbind \"
        bind - split-window -v -c "#{pane_current_path}"

        unbind \=
        bind \= resize-pane -Z

        unbind r
        bind r command-prompt -I "#{window_name}" "rename-window '%%'"

        unbind R
        bind R command-prompt -I "#{session_name}" "rename-session '%%'"

        unbind x
        bind x kill-pane

        unbind M-n
        bind -n M-n next-window
        unbind M-p
        bind -n M-p previous-window

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        unbind -T copy-mode-vi MouseDragEnd1Pane
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      '';
    };
  };
}

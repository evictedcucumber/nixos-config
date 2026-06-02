{...}: {
  flake.homeModules.tmux = {pkgs, ...}: {
    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = rose-pine;
          extraConfig = ''
            set -g @rose_pine_variant 'main'

            set -g @rose_pine_directory 'on'
          '';
        }
      ];
      extraConfig = ''
        set -g default-terminal "tmux-256color"
        set -as terminal-overrides ",xterm-256color:Tc"
        set -g status-position top
      '';
    };
  };
}

{
  config,
  ...
}: let
  mkSymlink = link: (import ../../../lib/mkSymlink.nix) link config;
in {
  programs.fish = {
    enable = true;
    loginShellInit = ''
      if test "$TERM" != "tmux-256color"
        fastfetch
      end
    '';
    shellInit = ''
      set -u fish_greeting ""

      fish_config theme choose "Rosé Pine"
    '';
    shellAbbrs = {
      v = "nvim";
      cat = "bat";
      catp = "bat -p";
      grep = "rg";
      find = "fd";
      ls = "eza";
      la = "eza -l -h --no-time --group";
      lt = "eza -T -I='.git'";
      "z-" = "z -";
      "z.." = "z ..";
    };
    interactiveShellInit = ''
      bind \cf y
      bind \cj down-or-search
      bind \ck up-or-search
    '';
  };

  xdg.configFile."fish/themes".source = mkSymlink "shells/fish/themes";
}

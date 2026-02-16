{...}: {
  programs.fish = {
    enable = true;
    loginShellInit = "fastfetch";
    shellInit = "set -u fish_greeting \"\"";
    shellInitLast = ''
      status is-interactive; and begin
        enable_transience
      end
    '';
    shellAbbrs = {
      v = "NVIM_APPNAME=neovim nvim";
      cat = "bat";
      mkdir = "mkdir -p";
      grep = "rg";
      ls = "eza -a -F=always --icons always --group-directories-first --sort=name -1 --colour always";
      la = "eza -a -F=always --icons always --group-directories-first --sort=name -1 --colour always --git -l -h --no-time --group";
      lt = "eza -a -F=always --icons always --group-directories-first --sort=name -1 --colour always -T -I='.git'";
      "z-" = "z -";
      "z.." = "z ..";
    };
    interactiveShellInit = ''
      bind \cf y
      bind \cj down-or-search
      bind \ck up-or-search
    '';
  };
}

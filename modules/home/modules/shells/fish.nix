{self, ...}: {
  flake.homeModules.fish = {...}: {
    imports = with self.homeModules; [
      eza
      fastfetch
    ];

    programs.fish = {
      enable = true;
      loginShellInit = "fastfetch";
      shellInit = ''
        set -u fish_greeting ""

        fish_config theme choose "Rosé Pine"
      '';
      shellAbbrs = {
        v = "NVIM_APPNAME=neovim nvim";
        vd = "NVIM_APPNAME=neovim DEBUG_PLENARY=true nvim";
        cat = "bat";
        grep = "rg";
        ls = "eza";
        ll = "eza -l -h --no-time --group";
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

    xdg.configFile."fish/themes".source = ../../../../config/shells/fish/themes;
  };
}

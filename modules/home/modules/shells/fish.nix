{
  self,
  inputs,
  ...
}: {
  flake.homeModules.fish = {pkgs, ...}: {
    imports = with self.homeModules; [
      eza
      fastfetch
    ];

    programs.fish = {
      enable = true;
      loginShellInit = "fastfetch";
      shellInit = ''
        set -u fish_greeting ""

        fish_config theme choose catppuccin-mocha --color-theme=dark
      '';
      shellAbbrs = {
        v = "NVIM_APPNAME=neovim nvim";
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

        # Temporary fix for incorrect location in enableFishIntegration for programs.television
        source ${inputs.television.packages.${pkgs.stdenv.system}.default}/share/fish/vendor_completions.d/tv.fish
      '';
    };
  };
}

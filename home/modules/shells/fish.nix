{
  lib,
  config,
  ...
}: let
  mkSymlink = link: (import ../../../utilities/mkSymlink.nix) link config;
in {
  options.me.shells.fish = {
    enable = lib.mkEnableOption "Enable Fish Shell";
    integrations.enable = lib.mkEnableOption "Enable Fish Shell Integrations";
  };

  config = lib.mkIf config.me.shells.fish.enable {
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
  };
}

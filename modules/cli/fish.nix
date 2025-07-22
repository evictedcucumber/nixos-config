{
  lib,
  config,
  pkgs,
  ...
}: let
  catpuccin_theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "main";
    sha256 = "sha256-Oc0emnIUI4LV7QJLs4B2/FQtCFewRFVp7EDv8GawFsA=";
  };
in {
  imports = [
    ./bat.nix
    ./fastfetch.nix
    ./zoxide.nix
    ./eza.nix
    ./ripgrep.nix
    ./nix-your-shell.nix
  ];

  options = {me.cli.fish.enable = lib.mkEnableOption "Enable Fish";};

  config = lib.mkIf config.me.cli.fish.enable {
    me.cli.bat.enable = true;
    me.cli.fastfetch.enable = true;
    me.cli.zoxide.enable = true;
    me.cli.ripgrep.enable = true;
    me.cli.eza.enable = true;
    me.cli.nix-your-shell = {
      enable = true;
      enableFish = true;
    };

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
        bind \cf yy
        bind \cj down-or-search
        bind \ck up-or-search
      '';
    };

    home.file.".config/fish/themes/Catppuccin Mocha.theme".source = "${catpuccin_theme}/themes/Catppuccin Mocha.theme";
  };
}

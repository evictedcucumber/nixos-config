{
  config,
  pkgs,
  stateVersion,
  helium-browser,
  username,
  ...
}: let
  bottomTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bottom";
    rev = "main";
    sha256 = "sha256-dfukdk70ug1lRGADKBnvMhkl+3tsY7F+UAwTS2Qyapk=";
  };
in {
  imports = [./modules/cli ./modules/tui ./modules/gui];

  me.cli.git.signingkey = "A2FD5AF74494FD44";

  home = {
    inherit username;
    homeDirectory = "/home/${config.home.username}";
    stateVersion = stateVersion;
    sessionVariables = {
      FZF_DEFAULT_OPTS = ''
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
        --color=selected-bg:#45475a
        --color=border:#313244,label:#cdd6f4
      '';
      BAT_THEME = "catppuccin";
      EDITOR = "nvim";
    };
    sessionPath = [
      "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
    ];
    packages = with pkgs; [
      ffmpeg
      file
      imagemagick
      jq
      p7zip
      poppler
      resvg
      javaPackages.compiler.openjdk21

      ## GUI
      brave
      obsidian
      helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      ## /GUI

      ## FONTS
      inter
      nerd-fonts.jetbrains-mono
      ## /FONTS
    ];
  };

  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.local/cache";
    configFile = {
      "bottom/bottom.toml".source = "${bottomTheme}/themes/mocha.toml";
      "zellij/config.kdl".source = ./configs/zellij-config.kdl;
      "zellij/layouts/default.kdl".source = ./configs/zellij-layout.kdl;
    };
  };

  programs.home-manager.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;
  programs.fd.enable = true;
  programs.fastfetch.enable = true;
  programs.eza.enable = true;
  programs.bottom.enable = true;
  programs.zellij.enable = true;
}

{
  config,
  lib,
  ...
}: {
  options = {
    me.cli.fzf.enable = lib.mkEnableOption "Enable FZF";
  };

  config = lib.mkIf config.me.cli.fzf.enable {
    home.sessionVariables = {
      FZF_DEFAULT_OPTS = ''
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
        --color=selected-bg:#45475a
        --color=border:#313244,label:#cdd6f4
      '';
    };

    programs.fzf.enable = true;
  };
}

{
  lib,
  config,
  ...
}: {
  options.me.navigation.fzf.enable = lib.mkEnableOption "Enable FZF";

  config = lib.mkIf config.me.navigation.fzf.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = config.me.shells.fish.integrations.enable;
      defaultOptions = [
        "--color=fg:#908caa,bg:#191724,hl:#ebbcba"
        "--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba"
        "--color=border:#403d52,header:#31748f,gutter:#191724"
        "--color=spinner:#f6c177,info:#9ccfd8"
        "--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
      ];
    };
  };
}

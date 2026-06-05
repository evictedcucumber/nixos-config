{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.programming.treesitter.enable = lib.mkEnableOption "Enable Treesitter";

  config = lib.mkIf config.me.programming.treesitter.enable {
    home.packages = with pkgs; [tree-sitter];
  };
}

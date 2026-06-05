{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.programming.mermaid.enable = lib.mkEnableOption "Enable Mermaid Compiler";

  config = lib.mkIf config.me.programming.mermaid.enable {
    home.packages = with pkgs; [mermaid-cli];
  };
}

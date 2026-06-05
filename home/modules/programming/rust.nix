{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.programming.rust.enable = lib.mkEnableOption "Enable Rust Compiler";

  config = lib.mkIf config.me.programming.rust.enable {
    home.packages = with pkgs; [
      (rust-bin.stable.latest.default.override {
        extensions = ["rust-analyzer"];
      })
    ];
  };
}

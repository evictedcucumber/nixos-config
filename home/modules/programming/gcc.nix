{
  lib,
  config,
  ...
}: {
  options.me.programming.gcc.enable = lib.mkEnableOption "Enable GCC Compiler";

  config = lib.mkIf config.me.programming.gcc.enable {
    programs.gcc.enable = true;
  };
}

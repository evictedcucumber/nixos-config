{
  lib,
  config,
  ...
}: {
  options.me.system.core.programs.enable = lib.mkEnableOption "Enable Program Options";

  config = lib.mkIf config.me.system.core.programs.enable {
    programs = {
      nix-ld.enable = true;
      gnupg.agent.enable = true;
      nh = {
        enable = true;
        clean = {
          enable = true;
          dates = "Tues 10:00";
        };
      };
      fish.enable = true;
      appimage = {
        enable = true;
        binfmt = true;
      };
    };
  };
}

{
  lib,
  config,
  ...
}: {
  imports = [./alacritty.nix];

  options = {me.gui.enable = lib.mkEnableOption "Enable GUI applications";};

  config = lib.mkIf config.me.gui.enable {me.gui.alacritty.enable = true;};
}

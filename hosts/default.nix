# Every directory here is a host; one with a disko.nix also gets a `<host>-iso` installer package.
{
  inputs,
  lib,
  ...
}: let
  mkSystem = import ../lib/mkSystem.nix {inherit inputs;};

  system = "x86_64-linux";
  username = "ethan";

  hosts = lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./.));
  diskoHosts = lib.filter (hostname: builtins.pathExists ./${hostname}/disko.nix) hosts;

  mkIso = hostname:
    (lib.nixosSystem {
      specialArgs = {
        inherit username;
        target = inputs.self.nixosConfigurations.${hostname};
      };
      modules = [../modules/nixos/installer.nix];
    }).config.system.build.isoImage;
in {
  flake.nixosConfigurations = lib.genAttrs hosts (hostname: mkSystem {inherit system hostname username;});

  perSystem.packages = lib.listToAttrs (map (hostname: lib.nameValuePair "${hostname}-iso" (mkIso hostname)) diskoHosts);
}

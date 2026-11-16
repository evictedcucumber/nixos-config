# Every directory here is a host. One with a disko.nix also gets a `<host>-iso` installer package,
# and a WSL host gets a `<host>-wsl` package that builds its .wsl file.
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
  wslHosts = lib.filter (hostname: inputs.self.nixosConfigurations.${hostname}.config.wsl.enable or false) hosts;

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

  perSystem.packages =
    lib.listToAttrs (map (hostname: lib.nameValuePair "${hostname}-iso" (mkIso hostname)) diskoHosts)
    // lib.listToAttrs (map (hostname: lib.nameValuePair "${hostname}-wsl" inputs.self.nixosConfigurations.${hostname}.config.system.build.tarballBuilder) wslHosts);
}

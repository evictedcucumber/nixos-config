# Every directory here is a host. One with a disko.nix also gets a `<host>-iso` installer package,
# and a WSL host gets a `<host>-wsl` package that builds its .wsl file with both repos cloned in.
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

  mkWslBuilder = hostname: let
    inherit (inputs.self.nixosConfigurations.${hostname}) config pkgs;
    user = config.users.users.${config.wsl.defaultUser};
    inherit (config.home-manager.users.${user.name}) me;
    owner = "${toString user.uid}:${toString config.users.groups.${user.group}.gid}";
  in
    pkgs.writeShellApplication {
      name = "build-${hostname}-wsl";
      runtimeInputs = [pkgs.git];
      text = ''
        extra=$(mktemp -d)
        trap 'rm -rf "$extra"' EXIT
        git clone https://github.com/evictedcucumber/nixos-config "$extra${me.flakePath}"
        git clone https://github.com/evictedcucumber/neovim-config "$extra${me.neovimConfigPath}"
        chmod ${user.homeMode} "$extra${user.home}"
        ${lib.getExe config.system.build.tarballBuilder} --extra-files "$extra" --chown ${user.home} ${owner} "$@"
      '';
    };
in {
  flake.nixosConfigurations = lib.genAttrs hosts (hostname: mkSystem {inherit system hostname username;});

  perSystem.packages =
    lib.listToAttrs (map (hostname: lib.nameValuePair "${hostname}-iso" (mkIso hostname)) diskoHosts)
    // lib.listToAttrs (map (hostname: lib.nameValuePair "${hostname}-wsl" (mkWslBuilder hostname)) wslHosts);
}

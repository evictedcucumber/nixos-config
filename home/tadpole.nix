{pkgs, ...}: let
  # Fabric requires invoke < 3 but nixpkgs ships 3.x, which marks it broken.
  # Pin it for azure-cli's Python set only, since paramiko also depends on invoke.
  # Drop this once https://github.com/fabric/fabric/issues/2376 is fixed.
  azure-cli = pkgs.azure-cli.override {
    inherit ((pkgs.extend (_: prev: {
        pythonPackagesExtensions =
          prev.pythonPackagesExtensions
          ++ [
            (pyFinal: pyPrev: {
              invoke = pyPrev.invoke.overridePythonAttrs (old: rec {
                version = "2.2.1";
                src = pyFinal.fetchPypi {
                  inherit (old) pname;
                  inherit version;
                  hash = "sha256-UVv0m0pIkyt5sCRZA0jaIvOcSULf+ZGtH7i4uuob5wc=";
                };
              });
            })
          ];
      }))) python3;
  };
in {
  imports = [./default.nix];

  # :: PACKAGES {
  home.packages = [pkgs.uv azure-cli];
  # :: }

  # :: SESSION VARIABLES {
  home.sessionVariables.LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc}/lib";
  # :: }

  # :: ME {
  # Delta on top of the common profile in ./default.nix.
  me.tools.ssh.extraConfig = {
    "vs-ssh.visualstudio.com" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/sb.key";
      kbdInteractiveAuthentication = "yes";
      passwordAuthentication = "no";
    };
  };
  # :: }
}

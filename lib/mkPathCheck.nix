# Activation step that fails when `path` is missing. It runs after every other
# step, so the rest of the home is still set up. Name the entry `mePathCheck<Something>`.
# Usage: home.activation.mePathCheckFlake = import mkPathCheck.nix {inherit lib config;} {option = "me.flakePath"; path = "…/flake.nix";};
{
  lib,
  config,
}: {
  option,
  path,
}:
lib.hm.dag.entryAfter (lib.filter (name: !lib.hasPrefix "mePathCheck" name) (lib.attrNames config.home.activation)) ''
  if [ ! -e ${lib.escapeShellArg path} ]; then
    errorEcho ${lib.escapeShellArg "${option}: ${path} does not exist. Clone the repo there or point ${option} at its new location."}
    exit 1
  fi
''

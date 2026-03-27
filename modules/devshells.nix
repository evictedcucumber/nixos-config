{...}: {
  perSystem = {pkgs, ...}: {
    devshells.default = {
      name = "nixos-config";
      packages = [pkgs.git];
      # commands = [
      #   {
      #     help = "Clone my NixOS config from github.";
      #     name = "nixos-config-clone";
      #     command = ''
      #       clone() {
      #         local dir
      #         if [[ -z $1 ]]; then
      #           echo Using default location.
      #           dir="~/repos/nixos-config";
      #         else
      #           dir=$1
      #         fi
      #       }
      #
      #     '';
      #   }
      # ];
    };
  };
}

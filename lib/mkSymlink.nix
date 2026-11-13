# Usage: let mkSymlink = link: (import mkSymlink.nix) link config; in
# Where: config = home-manager.config
link: config: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/nixos-config/config/${link}"

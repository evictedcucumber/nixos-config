{config, ...}: {
  imports = [./default.nix];

  # :: ME {
  me = {
    archive.zip.enable = true;
    databases.sqlite.enable = true;
    editors.neovim.enable = true;
    files.yazi.enable = true;
    multiplexers.tmux.enable = true;
    navigation = {
      fzf.enable = true;
      tv.enable = true;
      zoxide.enable = true;
    };
    programming = {
      gcc.enable = true;
      ghostscript.enable = true;
      java.enable = true;
      javascript.enable = true;
      latex.enable = true;
      lua.enable = true;
      mermaid.enable = true;
      python.enable = true;
      rust.enable = true;
      treesitter.enable = true;
    };
    searchers = {
      fd.enable = true;
      jq.enable = true;
      ripgrep.enable = true;
    };
    shells.fish = {
      enable = true;
      integrations.enable = true;
    };
    tools = {
      bat.enable = true;
      direnv.enable = true;
      eza.enable = true;
      git.enable = true;
      lazygit.enable = true;
      make.enable = true;
      nh = {
        enable = true;
        flake = "${config.home.homeDirectory}/repos/nixos-config";
      };
      ssh.enable = true;
      tealdeer.enable = true;
    };
    utilities = {
      fastfetch.enable = true;
      nix-your-shell.enable = true;
      starship.enable = true;
    };
    web = {
      curl.enable = true;
      wget.enable = true;
    };
  };
  # :: }
}

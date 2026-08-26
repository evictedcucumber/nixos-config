{config, ...}: {
  imports = [./default.nix];

  # :: ME {
  # Delta on top of the common profile in ./default.nix.
  me.tools = {
    git.settings.signingKey = "440DB3144C3649BA";
    hledger = {
      enable = true;
      ledgersDir = "${config.home.homeDirectory}/myvault/97 - Finance";
    };
  };
  # :: }
}

{...}: {
  flake.homeModules.hledger = {
    pkgs,
    homeConfig,
    config,
    ...
  }: {
    home.packages = with pkgs; [hledger hledger-ui hledger-web];

    xdg.configFile."hledger/hledger.conf".text = ''
      --pretty

      [ui] --theme=dark
    '';

    home.sessionVariables = {
      LEDGERS_DIR = homeConfig.hledgerLedgersDir;
      LEDGER_FILE = "${config.home.sessionVariables.LEDGERS_DIR}/main.journal";
      CURRENT_LEDGER_FILE = "${config.home.sessionVariables.LEDGERS_DIR}/current.journal";
      YEAR_LEDGER_FILE = "${config.home.sessionVariables.LEDGERS_DIR}/2026.journal";
    };
  };
}

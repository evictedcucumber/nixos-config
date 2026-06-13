{
  lib,
  config,
  pkgs,
  ...
}: {
  options.me.tools.hledger = {
    enable = lib.mkEnableOption "Enable Hledger";
    ledgersDir = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Set the LEDGERS_DIR Path";
    };
  };

  config = lib.mkIf config.me.tools.hledger.enable {
    home.packages = with pkgs; [hledger hledger-ui hledger-web];

    home.sessionVariables = {
      LEDGERS_DIR = config.me.tools.hledger.ledgersDir;
      LEDGER_FILE = "${config.home.sessionVariables.LEDGERS_DIR}/main.journal";
      CURRENT_LEDGER_FILE = "${config.home.sessionVariables.LEDGERS_DIR}/current.journal";
      YEAR_LEDGER_FILE = "${config.home.sessionVariables.LEDGERS_DIR}/2026.journal";
    };

    xdg.configFile."hledger/hledger.conf".text = ''
      --pretty -X R

      [ui] --theme=dark
    '';
  };
}

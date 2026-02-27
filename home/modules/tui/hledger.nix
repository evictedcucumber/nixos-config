{pkgs, ...}: {
  home.packages = with pkgs; [hledger hledger-ui hledger-web];

  xdg.configFile."hledger/hledger.conf".text = ''
    --pretty

    [ui] --theme=dark
  '';
}

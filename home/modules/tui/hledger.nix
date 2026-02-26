{pkgs, ...}: {
  home.packages = with pkgs; [hledger hledger-ui];
}

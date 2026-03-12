{...}: {
  programs = {
    nix-ld.enable = true;
    gnupg.agent.enable = true;
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "Tues 10:00";
      };
    };
    fish.enable = true;
  };
}

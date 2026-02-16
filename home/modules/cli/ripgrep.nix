{...}: {
  programs.ripgrep = {
    enable = true;
    arguments = ["--color=always"];
  };
}

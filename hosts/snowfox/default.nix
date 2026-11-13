_: {
  imports = [../../modules/nixos/wsl.nix];

  # :: SYSTEM {
  system.stateVersion = "26.11";
  # :: }

  # :: NIX {
  # WSL has no KVM on some Windows builds, so homelab tests run in nspawn, which needs uid-range.
  nix.settings = {
    experimental-features = ["auto-allocate-uids" "cgroups"];
    auto-allocate-uids = true;
    system-features = ["uid-range"];
  };
  # :: }
}

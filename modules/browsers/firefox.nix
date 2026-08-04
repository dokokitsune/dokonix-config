{
  # Firefox is the default browser on every host, so it contributes to `base`.
  # Contrast with browsers/zen.nix, which is a named aspect a host opts into.
  flake.modules.nixos.base = {
    programs.firefox.enable = true;
  };
}

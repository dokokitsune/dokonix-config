{ inputs, ... }: {
  flake.modules.nixos.orion = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.orion-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}

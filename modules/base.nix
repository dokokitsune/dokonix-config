{ config, ... }:
{
  flake.modules.nixos.base = {
    imports = with config.flake.modules.nixos; [
      nix
      networking
      nh
      determinate
      home-manager
    ];

    system.stateVersion = "26.05";
  };
}

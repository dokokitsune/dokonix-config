{
  flake.modules.nixos.networking =
    { pkgs, ... }:
    {
      hardware.bluetooth.enable = true;
      networking.networkmanager = {
        enable = true;
        plugins = with pkgs; [ networkmanager-openconnect ];
      };
      services = {
        tailscale.enable = true;
      };
    };
}

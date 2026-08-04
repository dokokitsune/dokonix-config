{ inputs, ... }:
{
  flake.modules.nixos.gpu-amd =
    { pkgs, ... }:
    {
      hardware = {
        graphics = {
          enable = true;
          enable32Bit = true;
          # pinned mesa from hyprland's nixpkgs to avoid amdgpu issues
          package = inputs.hyprland.inputs.nixpkgs
            .legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa;
        };
      };
      boot.kernelPackages = pkgs.linuxPackages; 
    };
}

{inputs, pkgs, ...}:
{
  imports = [./hardware-configuration.nix];
  networking.hostName = "dokotop";
  hardware.graphics = {
    enable = true;
    package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa;
  };
  hardware.amdgpu.amdvlk.enable = true;
  programs = {
    regreet = {
      enable = true;
      settings = {
        GTK = {
          application_prefer_dark_theme = true;
        };
      };
    };

  };
}

{ inputs, pkgs, ... }:
{


  programs = {

    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    hyprlock.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    xfce.thunar
    upower
    wlogout
    hyprpaper
    xdg-desktop-portal-hyprland
    hyprcursor
    hyprshot
    zoom-us
  ];

}

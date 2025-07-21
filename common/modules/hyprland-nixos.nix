{ inputs, pkgs, ... }:
{

  services = {
    hypridle.enable = true;
  };

  programs = {

    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
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
    obsidian
  ];

}

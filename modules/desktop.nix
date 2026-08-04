{ config, ... }:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      services.udisks2.enable = true;
      services.upower.enable = true;

      programs.dconf.enable = true;
      programs.thunar = {
        enable = true;
        plugins = with pkgs; [ thunar-volman ];
      };
      services.gvfs.enable = true;
      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };

      environment = {
        sessionVariables.NIXOS_OZONE_WL = "1";

        systemPackages = with pkgs; [
          wl-clipboard
          ddcutil
          nvd
        ];
      };
    };

  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        discord
        zoom-us
        btop
        fastfetch
        tldr
        tree
      ];
    };
}

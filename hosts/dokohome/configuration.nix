{ nixpkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  networking.hostName = "dokohome";
  programs = {
    regreet = {
      enable = true;
      settings = {
        background = {
          path = "/home/wwood/.dotfiles/hosts/dokohome/wallpapers/regreet-background.jpg";
          fit = "Contain";
        };
        GTK = {
          application_prefer_dark_theme = true;
        };
      };
    };

  };

}

{
  imports = [./hardware-configuration.nix];
  networking.hostName = "dokotop";
  programs = {
    regreet = {
      enable = true;
      settings = {
#        background = {
#          path = "/home/wwood/.dotfiles/hosts/dokotop/wallpapers/regreet-background.jpg";
#        };
        GTK = {
          application_prefer_dark_theme = true;
        };
      };
    };

  };
}

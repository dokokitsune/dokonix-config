{
  config,
  nixpkgs,
  pkgs,
  inputs,
  ...
}:
{
  home = {
    username = "dokotop";
    homeDirectory = "/home/dokotop";
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.vimix-cursors;
      name = "Vimix-cursors";
      size = 24;

    };
    packages = with pkgs; [
      discord
      btop
      fish
      fastfetch
      tldr
      tree
    ];

    stateVersion = "24.11";
  };

  programs = {
    home-manager.enable = true;
    fish.enable = true;
    starship.enable = true;
    ghostty = {
      enable = true;
      settings = {
        shell-integration = "fish";
        font-family = "FiraCode Nerd Font";
        gtk-titlebar = false;
        gtk-tabs-location = "hidden";
        background-opacity = 0.9;
        background-blur = true;
        theme = "tokyonight_night";
        

      };
    };

  };

}

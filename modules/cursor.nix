{
  flake.modules.homeManager.cursor =
    { pkgs, ... }:
    {
      home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.vimix-cursors;
        name = "Vimix-cursors"; # matches `$cursor` in the hyprland aspect
        size = 24;
      };
    };
}

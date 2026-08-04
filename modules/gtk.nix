{
  flake.modules.homeManager.gtk =
    { pkgs, ... }:
    {
      gtk = {
        enable = true;
        theme = {
          name = "catppuccin-mocha-blue-standard";
          package = pkgs.catppuccin-gtk.override { variant = "mocha"; };
        };
        iconTheme = {
          name = "kora";
          package = pkgs.kora-icon-theme;
        };
      };
    };
}

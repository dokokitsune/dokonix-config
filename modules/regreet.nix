{
  flake.modules.nixos.regreet =
    {
      programs.regreet = {
        enable = true;
        settings = {
          GTK = {
            application_prefer_dark_theme = true;
          };
        };
      };
    };

}

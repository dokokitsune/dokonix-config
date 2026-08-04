{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      settings = {
        shell-integration = "zsh";
        font-family = "FiraCode Nerd Font";
        gtk-titlebar = false;
        gtk-tabs-location = "hidden";
        background-opacity = 0.9;
        background-blur = true;
        theme = "TokyoNight Night";
        window-padding-x = "2";
      };
    };
  };
}

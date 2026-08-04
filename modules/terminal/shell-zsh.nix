{
  flake.modules.homeManager.zsh = {

    programs = {
      starship = {
        enable = true;
        enableZshIntegration = true;
        enableTransience = true;
      };
      eza = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = {
        enable = true;
      };
    };
  };
}

{
  flake.modules.homeManager.git =
    { pkgs, ... }:
    {
      programs.git = {
        enable = true;
        package = pkgs.gitFull;
  
        userName = "Weston Wood";
        userEmail = "stakin101@gmail.com";

        extraConfig = {
          credential.helper = "libsecret"; 
          init.defaultBranch = "main";
          pull.rebase = true;
        };
      };
    };
}

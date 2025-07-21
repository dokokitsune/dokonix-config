{
  config,
  nixpkgs,
  pkgs,
  inputs,
  ...
}:
{
  home = {
    username = "wwood";
    homeDirectory = "/home/wwood";
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.vimix-cursors;
      name = "Vimix-cursors";
      size = 24;

    };
    sessionVariables = {
      HYPRSHOT_DIR = "/home/wwood/Pictures/";
      EDITOR = "nvim";
      VISUAL = "nvim";
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

  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
  };

  programs = {
    home-manager.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        starship init fish | source
        enable_transience
        alias ls="eza"
      '';
    };
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
        window-padding-x = "2";

      };
    };
    k9s = {
      enable = true;

    };
  };
}

{ config, inputs, ... }:
{
  flake.modules.nixos.home-manager = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      extraSpecialArgs = { inherit inputs; };
      users.wwood =
        { osConfig, ... }:
        {
          home.stateVersion = osConfig.system.stateVersion;
          imports = with config.flake.modules.homeManager; [
            desktop
            noctalia
            walker
            hyprland
            ghostty
            zsh
            kubernetes
            git
            gtk
            cursor
            ai
            cloud
          ];
        };
    };
  };
}

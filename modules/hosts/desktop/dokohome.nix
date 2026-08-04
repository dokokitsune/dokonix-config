{ inputs, config, ... }:
{
  # Host-specific home-manager config: the physical facts about this machine
  # (ultrawide display, master layout, where its wallpapers live). Pulled into
  # the user's home config by the nixosConfiguration below.
  flake.modules.homeManager.dokohome = {
    local.hyprland.extraLua = ''
      hl.monitor({
        output   = "DP-1",
        mode     = "5120x1440@240",
        position = "0x0",
        scale    = 1,
        bitdepth = 10,
      })

      hl.config({
        general = {
          layout = "master",
        },
        master = {
          mfact       = 0.5,
          orientation = "center",
        },
      })
    '';

    programs.noctalia.settings.wallpaper.directory =
      "/home/wwood/.dotfiles/modules/hosts/desktop/wallpapers";
  };

  flake.nixosConfigurations.dokohome = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules =
      (with config.flake.modules.nixos; [
        base
        boot-grub
        cpu-amd
        gpu-amd
        desktop
        hyprland
        docker
        nvim
        regreet
        nfs
        zen
        orion
        steam
        makemkv
      ])
      ++ [

        { networking.hostName = "dokohome"; }
        ./_hardware-configuration.nix

        { home-manager.users.wwood.imports = [ config.flake.modules.homeManager.dokohome ]; }

        {
          # Greeter background. Referenced as a store path rather than a path
          # under /home, so greetd's own user can actually read it.
          programs.regreet.settings.background = {
            path = ./wallpapers/regreet-background.jpg;
            fit = "Contain";
          };
        }
      ];
  };
}

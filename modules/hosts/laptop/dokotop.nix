{ inputs, self, config, ... }:
{
  # Host-specific home-manager config: internal panel, dwindle layout, and
  # where this host's wallpapers live.
  flake.modules.homeManager.dokotop = {
    local.hyprland.extraLua = ''
      hl.monitor({
        output   = "eDP-1",
        mode     = "1920x1200@60",
        position = "0x0",
        scale    = 1,
      })

      hl.config({
        general = {
          layout = "dwindle",
        },
        dwindle = {
          preserve_split = true,
        },
      })
    '';

    programs.noctalia.settings.wallpaper.directory =
      "/home/wwood/.dotfiles/modules/hosts/laptop/wallpapers";
  };

  flake.nixosConfigurations.dokotop = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules =
      (with config.flake.modules.nixos; [
        base
        boot-grub
        gpu-amd
        laptop
        desktop
        hyprland
        docker
        nvim
        regreet
        nfs
        zen
      ])
      ++ [

        { networking.hostName = "dokotop"; }
        ./_hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd

        { home-manager.users.wwood.imports = [ config.flake.modules.homeManager.dokotop ]; }
      ];
  };
}

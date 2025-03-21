{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
    flox = {
      url = "github:flox/flox/v1.3.16";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-config = {
      url = "github:dokokitsune/nixcats-config";
    };
    walker.url = "github:abenz1267/walker";
    #nixvim = {
    # url = "github:nix-community/nixvim";
    # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
    # inputs.nixpkgs.follows = "nixpkgs";
    #  };
    zen-browser.url = "github:youwen5/zen-browser-flake";

  };

  outputs =
    inputs@{ flake-parts, nixpkgs, nixos-hardware, ... }:

    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {
        imports = [
          # Import home-manager's flake module
          inputs.home-manager.flakeModules.home-manager
        ];

        flake = {
          # Put your original flake attributes here.
          nixosConfigurations.dokotop = inputs.nixpkgs.lib.nixosSystem {
            specialArgs.inputs = inputs;
            modules = [
              ./common/configuration.nix
                nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
              { nixpkgs.overlays = [ inputs.hyprpanel.overlay ]; }
              {
                nixpkgs.config = {
                  allowUnfree = true;
                  permittedInsecurePackages = [ "terraform-1.11.0" ];
                };
                environment.systemPackages = [
                  inputs.ghostty.packages.x86_64-linux.default

                ];
              }

              inputs.home-manager.nixosModules.home-manager
              inputs.nvim-config.nixosModules.default
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "backup";
                  users.dokotop = import ./home;
                  extraSpecialArgs = { inherit inputs; };
                };
              }

            ];
          };

          
        };

        systems = [
          # systems for which you want to build the `perSystem` attributes
          "x86_64-linux"
          # ...
        ];
        perSystem =
          { pkgs, system, ... }:
          {
            # This sets `pkgs` to a nixpkgs with allowUnfree option set.

            _module.args.pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
              nixpkgs.overlay = true;

            };
          };

      }
    );

}

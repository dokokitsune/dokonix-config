{
  description = "Dentric Pattern Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    herdr.url = "github:herdrdev/herdr";
    nvim-config = {
      url = "github:dokokitsune/nvf-config";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    walker.url = "github:abenz1267/walker";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    orion-browser.url = "github:dokokitsune/orion-browser-flake";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

}

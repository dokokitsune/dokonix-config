{
  flake.modules.nixos.nvim =
    { inputs, pkgs, ... }:
    {
      environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
      environment.systemPackages = [
        inputs.nvim-config.packages.${pkgs.system}.default
      ];
    };
}

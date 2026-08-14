{
  flake.modules.homeManager.herdr =
    { inputs, pkgs, ... }:
    {
      home.packages = [
        inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
      xdg.configFile."herdr/config.toml".text = ''
        onboarding = false
      '';
    };
}

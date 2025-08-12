{ pkgs, inputs, ... }:
{

  boot.kernelPackages = pkgs.linuxPackages; # (this is the default) some amdgpu issues on 6.10
  hardware.xone.enable = true; # support for the xbox controller USB dongle
  services.getty.autologinUser = "dokokistune";

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa;
    };
    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };

  };

  environment = {
    systemPackages = with pkgs; [
      mangohud
      protonup
    ];
    loginShellInit = ''
      [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
    '';
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/wwood/.steam/root/compatibilitytools.d";
    };
  };

  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };
}

{ ... }: {

  flake.modules.nixos.steam = { pkgs, ... }:
    let
      gamescope-session = pkgs.writeShellScriptBin "gs" ''
        set -xeuo pipefail

        gamescopeArgs=(
            --adaptive-sync # VRR support
            --hdr-enabled
            --mangoapp # performance overlay
            --rt
            --steam
        )
        steamArgs=(
            -pipewire-dmabuf
            -tenfoot
        )
        mangoConfig=(
            cpu_temp
            gpu_temp
            ram
            vram
        )
        mangoVars=(
            MANGOHUD=1
            MANGOHUD_CONFIG="$(IFS=,; echo "''${mangoConfig[*]}")"
        )

        export "''${mangoVars[@]}"
        exec gamescope "''${gamescopeArgs[@]}" -- steam "''${steamArgs[@]}"
      '';
    in
    {

    hardware.xone.enable = true; 

    services.getty.autologinUser = "dokokistune";

    environment = {
      systemPackages = with pkgs; [
        mangohud
        protonup-ng
        gamescope-wsi
      ];
      loginShellInit = ''
        [[ "$(tty)" = "/dev/tty1" ]] && ${gamescope-session}/bin/gs
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
  };
}

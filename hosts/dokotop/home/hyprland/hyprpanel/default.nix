{ inputs,pkgs, ... }:
{


  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    package = inputs.hyprpanel.packages.${pkgs.system}.default;
    settings = {
      bar = {
        launcher.autoDetectIcon = true;
        workspaces.show_icons = true;
        clock.format = "%a %b %d %R";

      };
      layout = {
        "bar.layouts" = {
          "0" = {
            left = [
              "dashboard"
              "workspaces"
            ];
            middle = [
              "windowtitle"
              "notifications"
            ];
            right = [
              "cpu"
              "ram"
              "network"
              "battery"
              "clock"
            ];
          };
        };
      };

      menus = {
        clock = {
          time = {
            military = true;
            hideSeconds = true;
          };
          weather.unit = "imperial";
        };
        dashboard = {
          directories.enabled = false;
          stats.enable_gpu = true;

        };
      };
      theme = {
        name = "tokyo_night";
        bar.transparent = true;
        font = {
          name = "FiraCode Nerd Font";
          size = "14px";
        };

      };
    };
  };
}

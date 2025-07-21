{ inputs,pkgs, ... }:
{


  programs.hyprpanel = {

    systemd.enable = true;

    # Configure bar layouts for monitors.
    # See 'https://hyprpanel.com/configuration/panel.html'.
    # Default: null
    # Configure and theme almost all options from the GUI.
    # Options that require '{}' or '[]' are not yet implemented,
    # except for the layout above.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
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

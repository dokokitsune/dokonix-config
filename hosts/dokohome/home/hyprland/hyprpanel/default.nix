{ inputs, pkgs, ... }:
{

  programs.hyprpanel = {
    enable = true;
    package = inputs.hyprpanel.packages.${pkgs.system}.default;

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
        autoHide = "fullscreen";
        layouts = {
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
              "systray"
              "cpu"
              "ram"
              "volume"
              "network"
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
        bar = {
          transparent = true;
          buttons = {
            borderSize = "0.05em";
            enableBorders = true;
          };
        };
        font = {
          name = "FiraCode Nerd Font";
          size = "14px";
        };
      };
    };
  };
}

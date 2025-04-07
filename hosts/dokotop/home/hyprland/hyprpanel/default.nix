{ inputs, pkgs, ... }:
{

  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {

    # Enable the module.
    # Default: false
    enable = true;

    # Automatically restart HyprPanel with systemd.
    # Useful when updating your config so that you
    # don't need to manually restart it.
    # Default: false
    systemd.enable = true;

    # Add '/nix/store/.../hyprpanel' to your
    # Hyprland config 'exec-once'.
    # Default: false
    hyprland.enable = true;

    # Fix the overwrite issue with HyprPanel.
    # See below for more information.
    # Default: false
    overwrite.enable = true;

    # Import a theme from './themes/*.json'.
    # Default: ""

    # Override the final config with an arbitrary set.
    # Useful for overriding colors in your selected theme.
    # Default: {}
    override = {
      theme.bar.menus.text = "#123ABC";
    };

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

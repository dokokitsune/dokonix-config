{ inputs, ... }:
{
  flake.modules.homeManager.noctalia =
    { pkgs, ... }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;
        package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

        settings = {
          shell = {
            ui_scale = 1.0; # old general.scaleRatio
            corner_radius_scale = 1.0; # old general.radiusRatio
            telemetry_enabled = false; # old general.telemetryEnabled
            settings_show_advanced = false;
            avatar_path = "/home/wwood/.face"; # old general.avatarImage
            time_format = "{:%I:%M %p}"; # old location.use12hourFormat = true
            clipboard_auto_paste = "off"; # old appLauncher.autoPasteClipboard = false

            animation = {
              enabled = true; # old general.animationDisabled = false
              speed = 1.0; # old general.animationSpeed
            };

            shadow = {
              direction = "down_right"; # old general.shadowDirection = "bottom_right"
              alpha = 0.55;
            };

            panel = {
              transparency_mode = "solid";
              borders = false; # old ui.boxBorderEnabled / bar.showOutline = false
              launcher_placement = "centered"; # old appLauncher.position = "center"
              control_center_placement = "attached"; # old controlCenter "close_to_bar_button"
            };

            mpris.blacklist = [ ]; # old audio.mprisBlacklist
          };

          wallpaper = {
            enabled = true; # old wallpaper.enabled
            fill_mode = "crop"; # old wallpaper.fillMode
            transition_duration = 1500; # old wallpaper.transitionDuration
            edge_smoothness = 0.05; # old wallpaper.transitionEdgeSmoothness
            transition_on_startup = true; # old wallpaper.skipStartupTransition = false
            # `wallpaper.directory` is host-specific — each host sets it from
            # its own `flake.modules.homeManager.<host>` module.

            automation = {
              enabled = false; # old wallpaper.automationEnabled
              interval_minutes = 5; # old wallpaper.randomIntervalSec = 300
              order = "random"; # old wallpaper.wallpaperChangeMode
            };
          };

          theme = {
            mode = "dark"; # old colorSchemes.darkMode = true
            source = "builtin"; # old colorSchemes.useWallpaperColors = false
            builtin = "Tokyo-Night"; # old colorSchemes.predefinedScheme = "Tokyo Night"
          };

          notification = {
            enable_daemon = true; # old notifications.enabled
            layer = "overlay"; # old notifications.overlayLayer = true
            background_opacity = 1.0; # old notifications.backgroundOpacity
          };

          osd = {
            position = "top_right"; # old osd.location
            background_opacity = 1.0; # old osd.backgroundOpacity
          };

          lockscreen = {
            blurred_desktop = false;
            blur_intensity = 0.0; # old general.lockScreenBlur = 0
            tint_intensity = 0.0; # old general.lockScreenTint = 0
          };

          system.monitor.enabled = true; # old SystemMonitor widget present

          weather = {
            enabled = true; # old location.weatherEnabled
            unit = "celsius"; # old location.useFahrenheit = false
            effects = false; # old location.weatherShowEffects = false
          };

          audio = {
            enable_overdrive = false; # old audio.volumeOverdrive
            enable_sounds = false; # old audio.volumeFeedback
            sound_volume = 0.5; # old notifications.sounds.volume
          };

          brightness.enable_ddcutil = false; # old brightness.enableDdcSupport

          nightlight = {
            enabled = false; # old nightLight.enabled
            force = false; # old nightLight.forced
            temperature_day = 6500; # old nightLight.dayTemp
            temperature_night = 4000; # old nightLight.nightTemp
          };

          location = {
            auto_locate = false;
            address = "Tokyo"; # old location.name
          };

          idle.behavior = {
            lock = {
              timeout = 660; # old idle.lockTimeout
              enabled = false; # old idle.enabled = false
            };
            "screen-off" = {
              timeout = 600; # old idle.screenOffTimeout
              enabled = false;
            };
          };

          # Bar: old single-bar layout mapped to v5 widget type ids.
          # left → start, center → center, right → end.
          bar.main = {
            position = "top"; # old bar.position
            background_opacity = 0.93; # old bar.backgroundOpacity
            radius = 12; # old bar.frameRadius
            margin_h = 4; # old bar.marginHorizontal
            margin_v = 4; # old bar.marginVertical
            padding = 2; # old bar.contentPadding
            widget_spacing = 6; # old bar.widgetSpacing
            scale = 1.0; # old bar.fontScale
            shadow = true; # old general.enableShadows
            auto_hide = false; # old bar.displayMode = "always_visible"
            reserve_space = true;
            capsule = false; # old bar.showCapsule = false

            start = [
              "control-center" # old ControlCenter
              "media" # old MediaMini
              "workspaces" # old Workspace
            ];
            center = [
              "active_window" # old ActiveWindow
              "notifications" # old NotificationHistory
            ];
            end = [
              "tray" # old Tray
              "sysmon" # old SystemMonitor
              "battery" # old Battery
              "network" # old Network
              "clock" # old Clock
            ];
          };

          dock.enabled = false; # old dock.enabled

          desktop_widgets.enabled = false; # old desktopWidgets.enabled

          # old controlCenter.shortcuts mapped to documented v5 shortcut types.
          control_center.shortcuts = [
            { type = "wifi"; } # old Network
            { type = "bluetooth"; } # old Bluetooth
            { type = "wallpaper"; } # old WallpaperSelector
            { type = "notification"; } # old Notifications
            { type = "nightlight"; } # old NightLight
            { type = "session"; }
          ];

          widget = {
            clock = {
              format = "{:%a %b %-d %H:%M}"; # old bar Clock.formatHorizontal "ddd MMM d HH:mm"
              vertical_format = "{:%H\n%M}"; # old bar Clock.formatVertical
              tooltip_format = "{:%A, %B %d, %Y}";
            };
            sysmon.stat = "cpu_usage"; # old SystemMonitor.showCpuUsage = true
          };
        };
      };
    };
}

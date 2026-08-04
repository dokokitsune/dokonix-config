{ inputs, ... }:
{
  flake.modules.nixos.hyprland =
    { pkgs, ... }:
    {
      programs = {
        hyprland = {
          enable = true;
          withUWSM = true;
          package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          portalPackage =
            inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        };
      };
      environment.systemPackages = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.hyprshot
        pkgs.hyprcursor
      ];
    };

  flake.modules.homeManager.hyprland =
    { config, lib, pkgs, ... }:
    let
      startupScript = pkgs.writeShellScriptBin "start" ''
        systemctl --user start hyprpolkitagent &
        noctalia &
        walker --gapplication-service
      '';
    in
    {
      imports = [
        {
          options.local.hyprland.extraLua = lib.mkOption {
            type = lib.types.lines;
            default = "";
            description = "Host-specific Hyprland Lua config (monitors, layout).";
          };
        }
      ];

      home.packages = [
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
      ];

      home.sessionVariables = {
        HYPRSHOT_DIR = "/home/wwood/Pictures/";
      };

      xdg.configFile."uwsm/env".source =
        "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

      wayland.windowManager.hyprland = lib.mkForce {
        enable = true;
        configType = "lua";
        # Inherits from Nixos Module
        package = null;
        portalPackage = null;
        systemd = {
          variables = [ "--all" ];
          enable = false;
        };

        extraConfig = ''
          local mainMod = "SUPER"

          -- Autostart
          ----------------------------------------------------------------------
          hl.on("hyprland.start", function()
            hl.exec_cmd("${startupScript}/bin/start")
          end)

          ----------------------------------------------------------------------
          -- Look & feel / input / misc
          ----------------------------------------------------------------------
          hl.config({
            general = {
              gaps_in     = 2,
              gaps_out    = 2,
              border_size = 1,
              col = {
                active_border   = "rgba(27aaf5cc)",
                inactive_border = "rgba(595959aa)",
              },
              allow_tearing = false,
            },

            decoration = {
              rounding = 5,
              blur = {
                enabled = true,
                size    = 3,
                passes  = 1,
              },
            },

            animations = {
              enabled = true,
            },

            input = {
              kb_layout    = "us",
              follow_mouse = 1,
              touchpad = {
                natural_scroll = false,
              },
            },

            misc = {
              focus_on_activate              = true,
              disable_hyprland_logo          = true,
              disable_splash_rendering       = true,
            },
          })

          ----------------------------------------------------------------------
          -- Animations
          ----------------------------------------------------------------------
          hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

          hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
          hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
          hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
          hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
          hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
          hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

          ----------------------------------------------------------------------
          -- Keybindings
          ----------------------------------------------------------------------
          hl.bind(mainMod .. " + return",   hl.dsp.exec_cmd("ghostty"))
          hl.bind(mainMod .. " + C",        hl.dsp.window.close())
          hl.bind(mainMod .. " + M",        hl.dsp.exit())
          hl.bind(mainMod .. " + E",        hl.dsp.exec_cmd("thunar"))
          hl.bind(mainMod .. " + V",        hl.dsp.window.float({ action = "toggle" }))
          hl.bind(mainMod .. " + space",    hl.dsp.exec_cmd("walker"))
          hl.bind(mainMod .. " + P",        hl.dsp.window.pseudo())
          hl.bind(mainMod .. " + J",        hl.dsp.layout("togglesplit"))
          hl.bind("CONTROL + ALT + DELETE", hl.dsp.exec_cmd("wlogout"))

          -- Move focus
          hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
          hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
          hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" })) -- was "movefocus, u" (focused up); fixed to right
          hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

          -- Workspaces: switch (mainMod + N), move active window (mainMod + SHIFT + N)
          for i = 1, 10 do
            local key = i % 10 -- 10 maps to key 0
            hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
            hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
          end

          -- Special (scratchpad) workspace
          hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
          hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

          -- Scroll through workspaces
          hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
          hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

          -- Move/resize windows with mainMod + LMB/RMB
          hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
          hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

          -- Media & brightness keys
          hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s +10%"))
          hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"))
          hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
          hl.bind("Print",                 hl.dsp.exec_cmd("hyprshot -m region"))

          -- Repeating volume keys (was `binde`)
          hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
          hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })

          ----------------------------------------------------------------------
          -- Host-specific (monitors, layout)
          ----------------------------------------------------------------------
          ${config.local.hyprland.extraLua}
        '';
      };
    };
}

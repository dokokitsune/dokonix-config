{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    regreet &
    systemctl --user start hyprpolkitagent &
    udiskie &
    hyprpanel &
    hyprpaper &
    nm-applet &
    walker --gapplication-service 
  '';
in
{
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "~/.dotfiles/hosts/dokohome/wallpapers/lofi-escape.jpg";
      wallpaper = "DP-1, ~/.dotfiles/hosts/dokohome/wallpapers/lofi-escape.jpg";
    };
  };

  wayland.windowManager.hyprland = lib.mkForce {
    enable = true;
    # Inherits from Nixos Module
    package = null;
    portalPackage = null;
    systemd = {
      variables = [ "--all" ];
      enable = false;
    };

    settings = {
      "$cursor" = "Vimix-cursors";
      "$mod" = "SUPER";
      exec-once = ''${startupScript}/bin/start'';

      monitor = "DP-1, 5120x1440@240, 0x0, 1, bitdepth, 10";

      input = {
        kb_layout = "us";
        follow_mouse = "1";
        touchpad = {
          natural_scroll = "no";
        };
      };
      general = {
        gaps_in = 2;
        gaps_out = 2;
        border_size = 1;
        "col.active_border" = "rgba(27aaf5cc)  ";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "master";
        allow_tearing = "false";
      };
      master = {
        mfact = 0.5;
        orientation = "center";
        #        always_center_master = true;

      };
      decoration = {
        rounding = 5;
        blur = {
          enabled = "true";
          size = 3;
          passes = 1;
        };
      };
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      gestures = {
        workspace_swipe = "off";
      };
      misc = {
        focus_on_activate = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_hyprland_qtutils_check = true;
        force_default_wallpaper = -1;
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, return, exec, ghostty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, thunar"
        "$mainMod, V, togglefloating,"
        "$mainMod, space, exec, walker"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "CONTROL ALT, DELETE, exec, wlogout"

        "$mainMod, left, movefocus, l"
        "$mainMod, up, movefocus, u"
        "$mainMod, right, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        ",XF86MonBrightnessUp, exec, brightnessctl s +10%"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",Print, exec, hyprshot -m region "

      ];

      binde = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

    };
  };

}

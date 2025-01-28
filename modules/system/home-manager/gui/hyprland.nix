{ pkgs, lib, config, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [ hy3 ];
    settings = {
      "$terminal" = "${lib.getExe pkgs.kitty}";
      "$mainMod" = "SUPER";
      monitor = ",preferred,auto,1";
      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 0;
        gaps_out = 2;
        border_size = 2;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "$accent $lavender 45deg";
        "col.inactive_border" = "$overlay0";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "hy3";
      };

      layerrule = [ "blur, bar" ];
      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 0.9;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "$mantle";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };
      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true;
      };
      input = {
        resolve_binds_by_sym = 1;
        follow_mouse = 2;
        touchpad = {
          natural_scroll = false;
        };
      };

      plugin = {
        hy3 = {
          autotile = {
            enable = true;
          };
        };
      };
      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod SHIFT, C, killactive"
        "$mainMod SHIFT, E, exit"
        "$mainMod, R, exec, ${lib.getExe pkgs.rofi} -show run"
        "$mainMod, L, exec, ${lib.getExe pkgs.hyprlock} --immediate"
        "$mainMod, V, exec, cliphist list |  ${lib.getExe pkgs.rofi} -dmenu | cliphist decode | wl-copy -pc"
        "$mainMod, left, hy3:movefocus, l"
        "$mainMod, right, hy3:movefocus, r"
        "$mainMod, up, hy3:movefocus, u"
        "$mainMod, down, hy3:movefocus, d"
        "$mainMod SHIFT, left, hy3:movewindow, l"
        "$mainMod SHIFT, right, hy3:movewindow, r"
        "$mainMod SHIFT, up, hy3:movewindow, u"
        "$mainMod SHIFT, down, hy3:movewindow, d"
      ] ++ builtins.foldl'
        (acc: n: acc ++ [
          "$mainMod, code:1${builtins.toString n}, workspace, ${builtins.toString (n+1)}"
          "$mainMod SHIFT, code:1${builtins.toString n}, hy3:movetoworkspace, ${builtins.toString (n+1)}"
        ]) [ ]
        (lib.range 0 9);
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, ${lib.getExe pkgs.light} -A 5"
        ",XF86MonBrightnessDown, exec, ${lib.getExe pkgs.light} -U 5"
      ];

      # Requires playerctl
      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
        ",switch:on:Lid Switch, exec, systemctl suspend"
      ];
      # Fix some dragging issues with XWayland
      windowrulev2 = "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0";
      exec-once = [
        "kanshi"
        "systemctl --user enable --now hyprpolkitagent.service"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "udiskie"
      ];
      source = [ "/etc/wayland/common.conf" ];
    };
  };
}

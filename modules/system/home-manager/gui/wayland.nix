{ pkgs, lib, config, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];
    };
  };
  programs.waybar = {
    enable = true;
  };
  services.cliphist.enable = true;
  programs.rofi.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [ hy3 ];
    extraConfig = ''
            follow_mouse=0
            monitor=,preferred,auto,1
            $terminal = ${lib.getExe pkgs.wezterm}
            $menu = ${lib.getExe pkgs.dmenu}
            env = XCURSOR_SIZE,24
            env = HYPRCURSOR_SIZE,24
            $mainMod = SUPER
      # https://wiki.hyprland.org/Configuring/Variables/#general
      general {
          gaps_in = 5
          gaps_out = 20

          border_size = 2

          # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = false

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false

          layout = hy3
      }
      decoration {
          rounding = 10

          # Change transparency of focused and unfocused windows
          active_opacity = 1.0
          inactive_opacity = 1.0

          shadow {
              enabled = true
              range = 4
              render_power = 3
              color = rgba(1a1a1aee)
          }

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          blur {
              enabled = true
              size = 3
              passes = 1

              vibrancy = 0.1696
          }
      }

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations {
          enabled = yes, please :)

          # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = easeOutQuint,0.23,1,0.32,1
          bezier = easeInOutCubic,0.65,0.05,0.36,1
          bezier = linear,0,0,1,1
          bezier = almostLinear,0.5,0.5,0.75,1.0
          bezier = quick,0.15,0,0.1,1

          animation = global, 1, 10, default
          animation = border, 1, 5.39, easeOutQuint
          animation = windows, 1, 4.79, easeOutQuint
          animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
          animation = windowsOut, 1, 1.49, linear, popin 87%
          animation = fadeIn, 1, 1.73, almostLinear
          animation = fadeOut, 1, 1.46, almostLinear
          animation = fade, 1, 3.03, quick
          animation = layers, 1, 3.81, easeOutQuint
          animation = layersIn, 1, 4, easeOutQuint, fade
          animation = layersOut, 1, 1.5, linear, fade
          animation = fadeLayersIn, 1, 1.79, almostLinear
          animation = fadeLayersOut, 1, 1.39, almostLinear
          animation = workspaces, 1, 1.94, almostLinear, fade
          animation = workspacesIn, 1, 1.21, almostLinear, fade
          animation = workspacesOut, 1, 1.94, almostLinear, fade
      }
      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master {
          new_status = master
      }

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc {
          force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
      }
            input {
              kb_layout = fr
          touchpad {
              natural_scroll = false
          }
            }
            bind = $mainMod, Return, exec, $terminal
            bind = $mainMod, M, exit,
            bind = $mainMod, R, exec, $menu
      bind = $mainMod, left, hy3:movefocus, l
      bind = $mainMod, right, hy3:movefocus, r
      bind = $mainMod, up, hy3:movefocus, u
      bind = $mainMod, down, hy3:movefocus, d
      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, code:10, workspace, 1
      bind = $mainMod, code:11, workspace, 2
      bind = $mainMod, code:12, workspace, 3
      bind = $mainMod, code:13, workspace, 4
      bind = $mainMod, code:14, workspace, 5
      bind = $mainMod, code:15, workspace, 6
      bind = $mainMod, code:16, workspace, 7
      bind = $mainMod, code:17, workspace, 8
      bind = $mainMod, code:18, workspace, 9
      bind = $mainMod, code:19, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, code:10, movetoworkspace, 1
      bind = $mainMod SHIFT, code:11, movetoworkspace, 2
      bind = $mainMod SHIFT, code:12, movetoworkspace, 3
      bind = $mainMod SHIFT, code:13, movetoworkspace, 4
      bind = $mainMod SHIFT, code:14, movetoworkspace, 5
      bind = $mainMod SHIFT, code:15, movetoworkspace, 6
      bind = $mainMod SHIFT, code:16, movetoworkspace, 7
      bind = $mainMod SHIFT, code:17, movetoworkspace, 8
      bind = $mainMod SHIFT, code:18, movetoworkspace, 9
      bind = $mainMod SHIFT, code:19, movetoworkspace, 10
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Laptop multimedia keys for volume and LCD brightness
      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

      # Requires playerctl
      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous

      # Fix some dragging issues with XWayland
      windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

      exec-once = ${lib.getExe pkgs.hyprpolkitagent}
      exec-once = ${lib.getExe pkgs.hyprlock}
      exec-once = udiskie
      exec-once = nm-applet
    '';
  };
}

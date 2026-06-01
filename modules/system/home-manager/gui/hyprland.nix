{ pkgs, lib, config, ... }:
{
  catppuccin.hyprland.enable = false; # remove when switched to lua
  wayland.windowManager.hyprland = {
    enable = true;
        # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
#    configType = "lua";
    configType = "hyprlang";
    package = null;
    portalPackage = null;
    plugins = with pkgs.hyprlandPlugins; [ hy3 ];
    settings = {
      monitor = ",preferred,auto,1";
      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 1;
        gaps_out = 0;
        border_size = 0;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
# uncomment once catppucin is back
#        "col.active_border" = "${config.catppuccin.accent}";
#        "col.inactive_border" = "$overlay0";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "hy3";
      };

      layerrule = [
     {name = "blur waybar";
      blur = true;
      "match:namespace" = "waybar";
      }
     {name = "blur rofi";
      blur = true;
      "match:namespace" = "rofi";
      }
     {name = "blur logout";
      blur = true;
      "match:namespace" = "logout_dialog";
      }
      ];
      decoration = {
        rounding = 0;

        dim_inactive = false;
        dim_strength = 0.25;

        shadow = {
          enabled = false;
          #  range = 4;
          #  render_power = 3;
          #  color = "${config.catppuccin.accent}";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
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
        "SUPER, Return, exec, ${lib.getExe pkgs.kitty}"
        "SUPER SHIFT, C, killactive"
        "SUPER SHIFT, E, exit"
        "SUPER, R, exec, ${lib.getExe pkgs.rofi} -show run"
        "SUPER, L, exec, ${lib.getExe pkgs.hyprlock} --grace 0"
        "SUPER, V, exec, cliphist list |  ${lib.getExe pkgs.rofi} -dmenu | cliphist decode | wl-copy -pc"
        "SUPER, C, exec, ${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | wl-copy"
        "SUPER, left, hy3:movefocus, l"
        "SUPER, right, hy3:movefocus, r"
        "SUPER, up, hy3:movefocus, u"
        "SUPER, down, hy3:movefocus, d"
        "SUPER SHIFT, left, hy3:movewindow, l"
        "SUPER SHIFT, right, hy3:movewindow, r"
        "SUPER SHIFT, up, hy3:movewindow, u"
        "SUPER SHIFT, down, hy3:movewindow, d"
      ] ++ builtins.foldl'
        (acc: n: acc ++ [
          "SUPER, code:1${builtins.toString n}, workspace, ${builtins.toString (n+1)}"
          "SUPER SHIFT, code:1${builtins.toString n}, hy3:movetoworkspace, ${builtins.toString (n+1)}"
        ]) [ ]
        (lib.range 0 9);
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} set +5%"
        ",XF86MonBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} set -5%"
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
      #windowrule = "nofocus,match:class ^$,match:title ^$,match:xwayland true,match:floating: true,match:fullscreen false,match:pin false";
      exec-once = [
        "kanshi"
        "systemctl --user enable --now hyprpolkitagent.service"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --primary --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "udiskie"
      ];
      source = [ "/etc/wayland/common.conf" ];
    };
  };
}

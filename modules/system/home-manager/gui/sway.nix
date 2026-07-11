{ pkgs, lib, config, ... }:
{
  wayland.windowManager.sway =
    let
      modifier = "Mod4";
    in
    {
      enable = true;
      config = {
        inherit modifier;

        terminal = "${lib.getExe pkgs.kitty}";

        keybindings = lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${lib.getExe pkgs.kitty}";
          "${modifier}+r" = "exec ${lib.getExe pkgs.rofi} -show run";
          "${modifier}+l" = "exec ${lib.getExe pkgs.hyprlock}";
          "${modifier}+Shift+c" = "kill";
          "${modifier}+c" = "exec sh -c '${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}'";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86MonBrightnessUp" = "exec ${lib.getExe pkgs.brightnessctl} set +5%";
          "XF86MonBrightnessDown" = "exec ${lib.getExe pkgs.brightnessctl} set -5%";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPause" = "exec playerctl play-pause";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPrev" = "exec playerctl previous";
        };

        keycodebindings = (builtins.foldl'
          (acc: n: acc // {
            "${modifier}+1${builtins.toString n}" = "workspace number ${builtins.toString (n+1)}";
            "${modifier}+Shift+1${builtins.toString n}" = "move container to workspace number ${builtins.toString (n+1)}";
          })
          { }
          (lib.range 0 9))
        ;

        bars = [
          { command = pkgs.lib.getExe pkgs.waybar; }
        ];
        input = {
          "*" = {
            xkb_layout = "fr";
            xkb_variant = "\"\"";
          };
          "12951:18804:ZSA_Technology_Labs_ErgoDox_EZ_Keyboard" = {
            xkb_layout = "fr";
            xkb_variant = "bepo";
          };
        };
        colors = {
          focused = {
            background = "\$${config.catppuccin.accent}";
            border = "\$${config.catppuccin.accent}";
            childBorder = "\$${config.catppuccin.accent}";
            indicator = "#2e9ef4";
            text = "\$crust";
          };
          unfocused = {
            background = "\$overlay0";
            border = "\$overlay0";
            childBorder = "\$overlay0";
            indicator = "#2e9ef4";
            text = "\$crust";
          };
        };
        focus = {
            followMouse = false;
        };
        output = {
          "*" = {
            bg = "${./background-image} fit";
          };
        };
      };
    };
}

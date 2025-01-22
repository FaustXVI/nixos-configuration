{ pkgs, lib, config, ... }:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "network"
          "group/monitoring"
          "battery"
          "pulseaudio"
          "backlight"
          "tray"
          "clock"
          "custom/poweroff"
        ];

        tray = {
          spacing = 10;
        };
        clock = {
          interval = 1;
          format = "{:%Y-%m-%d %H:%M:%S}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
        "group/monitoring" = {
          orientation = "inherit";
          drawer = {
            click-to-reveal = true;
          };
          modules = [
            "cpu"
            "memory"
            "temperature"
          ];
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = {
          format = "{}% ";
        };
        temperature = {
          thermal-zone = 1;
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "󱗗" ];
        };
        backlight = {
          format = "{icon}";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
          on-scroll-up = "${lib.getExe pkgs.light} -A 1";
          on-scroll-down = "${lib.getExe pkgs.light} -U 1";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% ";
          format-icons = [ "" "" "" "" "" ];
          tooltip = false;
        };
        network = {
          format-wifi = "{ipaddr} {essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr} 󰈀";
          format-disconnected = "󰌙";
          format-linked = "{ifname} (No IP)";
          tooltip-format = "{ifname} via {gwaddr}";
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-bluetooth-muted = " {icon}";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
        "custom/poweroff" = {
          format = "󱄅";
          tooltip = false;
          on-click = "wlogout";
        };
      };
    };
  };
}

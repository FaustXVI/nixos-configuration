{ pkgs, lib, config, ... }:
{
  services.playerctld.enable = true;
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    style = ''
      * {
        font-size: 18px;
        min-height: 0;
      }

      #waybar {
        background: transparent;
        color: @text;
      }

      #workspaces button {
        color: @text;
        border: 2px;
        padding: 0.4rem;
      }

      #workspaces button.active,
      #workspaces button.visible,
      #workspaces button.focus
      {
        background: @${config.catppuccin.accent};
        color: @crust;
      }

      #workspaces button.urgent {
        background: @red;
        color: @crust;
      }

      #workspaces button:hover {
        background: @green;
        color: @crust;
      }

      #workspaces,
      #monitoring,
      #status,
      #datetime,
      #custom-poweroff {
        border-radius: 0 0 1rem 1rem;
        background: alpha(@surface0, 0.8);
        padding: 0.5rem 1rem;
        margin-right: 1rem;
      }
      #tray {
            padding : 0;
      }

      #clock.date {
        padding-right: 1rem;
      }

      #mpris {
        color: @green;
      }

      #battery {
        color: @text;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #pulseaudio,
      #backlight,
      #network {
        padding: 0 0.3rem;
        background: transparent;
      }

      #backlight {
        color: @yellow;
      }

      #pulseaudio.muted {
        color: @red;
      }

      #custom-poweroff {
          color: @blue;
      }

    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [
          "tray"
          "mpris"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "group/monitoring"
          "group/status"
          #"idle_inhibitor"
          "group/datetime"
          "custom/poweroff"
        ];

        tray = {
          spacing = 10;
        };
        "group/datetime" = {
          orientation = "inherit";
          modules = [
            "clock#date"
            "clock"
          ];
        };
        clock = {
          interval = 1;
          format = "{:%H:%M:%S}";
          tooltip = false;
        };
        "clock#date" = {
          format = "{:%Y-%m-%d}";
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
            "disk"
          ];
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        disk = {
          format = "{percentage_free}% 󰋊";
        };
        memory = {
          format = "{}% ";
        };
        temperature = {
          thermal-zone = 1;
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "󱗗" ];
        };
        "group/status" = {
          orientation = "inherit";
          modules = [
            "backlight"
            "battery"
            "network"
            "pulseaudio"
          ];
        };
        backlight = {
          format = "{icon}";
          tooltip-format = "{percent}%";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
          on-scroll-up = "${lib.getExe pkgs.light} -A 1";
          on-scroll-down = "${lib.getExe pkgs.light} -U 1";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-full = "{icon}";
          format-charging = "󰂄";
          format-plugged = "";
          format-icons = [ "" "" "" "" "" ];
          tooltip = true;
          tooltip-format = "{capacity}% : {time}";
        };
        mpris = {
          format = "{player_icon} {title} ";
          format-paused = "{player_icon} {title} {status_icon}";
          player-icons = {
            default = "";
            spotify = "";
            firefox = "";
          };
          status-icons = {
            paused = "";
          };
        };
        network = {
          format-wifi = "{icon}";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-ethernet = "󰈀";
          format-disconnected = "󰌙";
          format-linked = "{ifname} (No IP)";
          tooltip-format = "{ipaddr}";
          tooltip-format-wifi = "{ipaddr} on {essid} ({signalStrength}%)";
          on-click = "kitty nmtui";
        };
        pulseaudio = {
          format = "{icon}";
          format-tooltip = "{volume}% on {desc}";
          format-bluetooth = "{icon}";
          format-bluetooth-muted = " ";
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

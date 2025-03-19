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
        font-size: 14px;
      }

      #waybar {
        background: transparent;
        color: @text;
      }

      #workspaces button {
        color: @text;
        border: 0;
        padding: 0.2rem 0.4rem;
      }

      #workspaces button.active,
      #workspaces button.visible,
      #workspaces button.focus
      {
        color: @${config.catppuccin.accent};
        font-weight: bold;
      }

      #workspaces button.urgent {
        color: @text;
        background: transparent;
        border: 0;
        box-shadow: none;
        text-shadow: 0 0 2px @text, 0 0 4px @text, 0 0 6px @red, 0 0 8px @red, 0 0 10px @red, 0 0 12px @red, 0 0 14px @red;
        font-weight: bold;
      }

      #workspaces button:hover {
        background: transparent;
        border: 0;
        box-shadow: none;
        text-shadow: 0 0 2px @text, 0 0 4px @text, 0 0 6px @${config.catppuccin.accent}, 0 0 8px @${config.catppuccin.accent}, 0 0 10px @${config.catppuccin.accent}, 0 0 12px @${config.catppuccin.accent}, 0 0 14px @${config.catppuccin.accent};
        font-weight: bold;
      }

      #workspaces,
      #monitoring,
      #status,
      #datetime,
      #custom-poweroff {
        border-radius: 0 0 1rem 1rem;
        border: 2px solid @${config.catppuccin.accent};
        border-top: 0;
        background: alpha(@${config.catppuccin.accent},0.2);
        padding: 0.2rem 1rem;
        margin: 0 0.6rem 0 0.6rem;
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
      #network,
      #tray {
        padding: 0 0.4rem;
        background: transparent;
      }

      #pulseaudio.muted {
        color: @red;
      }

      #custom-poweroff {
          color: @${config.catppuccin.accent};
      }

    '';
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        modules-left = [
          "mpris"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "group/status"
          "group/monitoring"
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
            "tray"
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

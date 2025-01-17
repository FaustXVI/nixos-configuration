{ pkgs, lib, config, ... }:
let
  modifier = "Mod4";
  font = lib.lists.head config.fonts.fontconfig.defaultFonts.monospace;
  fonts = {
    names = [ font ];
    size = 14.0;
  };
in
{
  home.file.".background-image".source = ./background-image;
  xsession.windowManager.i3 = {
    enable = true;
    # Please see http://i3wm.org/docs/userguide.html for a complete reference!
    config = {
      inherit modifier fonts;
      assigns = {
        "1" = [{ class = "(?i)firefox"; }];
      };
      bars = [{
        inherit fonts;
        mode = "dock";
        hiddenState = "hide";
        position = "bottom";
        workspaceButtons = true;
        workspaceNumbers = true;
        statusCommand = "${pkgs.i3status}/bin/i3status";
        trayOutput = "primary";
        colors = {
          background = "#000000";
          statusline = "#ffffff";
          separator = "#666666";
          focusedWorkspace = {
            border = "#4c7899";
            background = "#285577";
            text = "#ffffff";
          };
          activeWorkspace = {
            border = "#333333";
            background = "#5f676a";
            text = "#ffffff";
          };
          inactiveWorkspace = {
            border = "#333333";
            background = "#222222";
            text = "#888888";
          };
          urgentWorkspace = {
            border = "#2f343a";
            background = "#900000";
            text = "#ffffff";
          };
          bindingMode = {
            border = "#2f343a";
            background = "#900000";
            text = "#ffffff";
          };
        };
      }];
      keybindings = {
        # start a terminal
        "${modifier}+Return" = "exec wezterm";
        # kill focused window
        "${modifier}+Shift+c" = "kill";
        # start dmenu
        "${modifier}+r" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        # change focus
        "${modifier}+Tab" = "focus right";
        "${modifier}+Shift+Tab" = "focus left";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+h" = "split h";
        "${modifier}+v" = "split v";

        "${modifier}+f" = "fullscreen toggle";

        # change container layout (stacked, tabbed, toggle split)
        "${modifier}+Shift+s" = "layout stacking";
        "${modifier}+Shift+t" = "layout tabbed";
        "${modifier}+Shift+h" = "layout toggle split";
        "${modifier}+Shift+v" = "layout toggle split";

        # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
        "${modifier}+Shift+r" = "restart";
        # exit i3 (logs you out of your X session)
        "${modifier}+Shift+e" = ''exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"'';
        "${modifier}+Shift+d" = ''mode "resize"'';
        "${modifier}+l" = "exec ${pkgs.i3lock}/bin/i3lock -t -i ~/.background-image";
        "XF86AudioRaiseVolume" = ''exec --no-startup-id ${pkgs.pamixer}/bin/pamixer -i 5'';
        "XF86AudioLowerVolume" = ''exec --no-startup-id ${pkgs.pamixer}/bin/pamixer -d 5'';
        "XF86AudioMute" = ''exec --no-startup-id ${pkgs.pamixer}/bin/pamixer -t'';
        "XF86MonBrightnessUp" = ''exec --no-startup-id ${pkgs.light}/bin/light -A 10'';
        "XF86MonBrightnessDown" = ''exec --no-startup-id ${pkgs.light}/bin/light -U 10'';
      };
      keycodebindings = {
        # switch to workspace
        "${modifier}+10" = "workspace 1";
        "${modifier}+11" = "workspace 2";
        "${modifier}+12" = "workspace 3";
        "${modifier}+13" = "workspace 4";
        "${modifier}+14" = "workspace 5";
        "${modifier}+15" = "workspace 6";
        "${modifier}+16" = "workspace 7";
        "${modifier}+17" = "workspace 8";
        "${modifier}+18" = "workspace 9";
        "${modifier}+19" = "workspace 10";

        # move focused container to workspace
        "${modifier}+Shift+10" = "move container to workspace 1";
        "${modifier}+Shift+11" = "move container to workspace 2";
        "${modifier}+Shift+12" = "move container to workspace 3";
        "${modifier}+Shift+13" = "move container to workspace 4";
        "${modifier}+Shift+14" = "move container to workspace 5";
        "${modifier}+Shift+15" = "move container to workspace 6";
        "${modifier}+Shift+16" = "move container to workspace 7";
        "${modifier}+Shift+17" = "move container to workspace 8";
        "${modifier}+Shift+18" = "move container to workspace 9";
        "${modifier}+Shift+19" = "move container to workspace 10";
      };
      modes = {
        resize = {
          Down = "resize grow height 10 px or 10 ppt";
          Left = "resize shrink width 10 px or 10 ppt";
          Right = "resize grow width 10 px or 10 ppt";
          Up = "resize shrink height 10 px or 10 ppt";
          Escape = "mode default";
          Return = "mode default";
        };
      };
      focus = {
        followMouse = false;
      };
      floating = {
        inherit modifier;
      };
      window = {
        commands = [
          {
            command = "focus";
            criteria = {
              "window_type" = "dialog";
            };
          }
        ];
      };
    };
  };
}

{ config, pkgs, mylib, ... }:

{
  config = {
    security.polkit.enable = true;
    boot.plymouth.enable = true;
    catppuccin = {
      autoEnable = true;
      accent = "sapphire";
      flavor = "mocha";
      enable = true;
    };
    hardware = {
      graphics = {
        enable = true;
      };
    };
    environment = {
      sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = 1;
        NIXOS_OZONE_WL = 1;
        XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
        XCURSOR_SIZE = 48;
        GDK_BACKEND = "wayland";
        MOZ_ENABLE_WAYLAND = 1;
      };
      systemPackages = with pkgs; [
        kitty
        #hyprcursor
        rofi
        wl-clipboard
        dmenu
        libnotify
        adwaita-icon-theme
        dunst
        arandr
        autorandr
        udiskie
        nautilus
        wlogout
        gscreenshot
      ];
    };
    services = {
      udisks2 = {
        enable = true;
      };
    };
    services.pipewire.wireplumber.enable = true;
    security.pam.services.hyprlock = { };
    services.greetd = {
      enable = true;
      settings = {
        default_session = let
  regreetSwayConfig = pkgs.writeText "sway-regreet-config" ''
    output * bg #222222 solid_color
    
    # Your AZERTY keyboard
    input "*" {
        xkb_layout fr
    }
    
    input "12951:18804:ZSA_Technology_Labs_ErgoDox_EZ" {
        xkb_layout fr
        xkb_variant bepo
    }

    exec "${pkgs.lib.getExe pkgs.regreet}; ${pkgs.lib.getExe' pkgs.sway "swaymsg"} exit"
  '';
        in {
          user = config.users.users.xadet.name;
          command = "${pkgs.lib.getExe' pkgs.dbus "dbus-run-session"} ${pkgs.lib.getExe pkgs.sway} --config ${regreetSwayConfig}";
        };
      };
    };
    xdg.portal = {
      enable = true;
      wlr ={ 
      enable = true;
            settings = {
        screencast = {
          chooser_type = "simple";
          chooser_cmd = "${pkgs.lib.getExe pkgs.slurp} -f 'Monitor: %o' -or";
        };
      };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];

    config.common = {
      # By default, use the GTK portal for things like file pickers
      default = [ "gtk" ];

      # Use the wlroots portal specifically for screen sharing/casting if requested
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
    };

      xdgOpenUsePortal = true;
    };
  };
}

{ config, pkgs, mylib, ... }:

{
  options = {
    default-monitor-config = pkgs.lib.mkOption {
      type = pkgs.lib.types.str;
      default =
        if mylib.computerIs "laptop" then
          "monitor = ,preferred,auto,1, mirror, eDP-1"
        else
          "monitor = ,preferred,auto,1";
    };
  };
  config = {
    security.polkit.enable = true;
    boot.plymouth.enable = true;
    catppuccin = {
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
        hyprcursor
        hyprpolkitagent
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
      ];
    };
    services = {
      udisks2 = {
        enable = true;
      };
    };
    services.pipewire.wireplumber.enable = true;
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    security.pam.services.hyprlock = { };
    programs.regreet = {
      enable = true;
    };
    environment.etc."wayland/common.conf".text = ''
      input {
        kb_layout = fr
      }

      device {
        name = zsa-technology-labs-ergodox-ez
        kb_variant = bepo
      }

      ${config.default-monitor-config}
    '';
    environment.etc."greetd/hyprland.conf".text = ''
      source = /etc/wayland/common.conf
      exec-once = ${pkgs.lib.getExe pkgs.greetd.regreet}; hyprctl dispatch exit
      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        #disable_hyprland_qtutils_check = true
      }
    '';
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.lib.getExe pkgs.hyprland} -c /etc/greetd/hyprland.conf";
          user = config.users.users.xadet.name;
        };
      };
    };
    # https://github.com/hyprwm/hyprland-wiki/issues/409
    xdg.portal = {
      enable = true;
      configPackages = with pkgs; [ hyprland ];
      config = {
        common = {
          default = [ "hyprland" "gtk" ];
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
      xdgOpenUsePortal = true;
    };
    # Fix xdg-portals opening URLs: https://github.com/NixOS/nixpkgs/issues/189851
    systemd.user.extraConfig = ''
      DefaultEnvironment="PATH=/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
    '';
  };
}

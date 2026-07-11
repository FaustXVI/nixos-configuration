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
        default_session = {
          user = config.users.users.xadet.name;
        };
      };
    };
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];

      xdgOpenUsePortal = true;
    };
  };
}

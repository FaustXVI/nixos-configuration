{ config, pkgs, ... }:

{
  security.polkit.enable = true;
  boot.plymouth.enable = true;
  hardware = {
    graphics = {
      enable = true;
    };
  };
  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = 1;
      NIXOS_OZONE_WL = 1;
      XCURSOR_SIZE = 48;
      HYPRCURSOR_SIZE = 48;
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
  environment.etc."wayland/keyboard.conf".text = ''
    input {
      kb_layout = fr
    }

    device {
      name = zsa-technology-labs-ergodox-ez
      kb_variant = bepo
    }
  '';
  environment.etc."greetd/hyprland.conf".text = ''
    source = /etc/wayland/keyboard.conf
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
}

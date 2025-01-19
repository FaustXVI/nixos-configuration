{ config, pkgs, ... }:

{
  hardware = {
    graphics = {
      enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      kitty
      wl-clipboard
      dmenu
      libnotify
      adwaita-icon-theme
      dunst
      arandr
      autorandr
      udiskie
      pasystray
      nautilus
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
  security.pam.services.hyprlock = {};
  #programs.regreet = {
  #  enable = true;

  #};
  #environment.etc."greetd/hyprland.conf".text = ''
  #                      input {
  #                        kb_layout = fr
  #                        kb_variant = bepo
  #                      }
  #      exec-once = ${pkgs.lib.getExe pkgs.greetd.regreet}; hyprctl dispatch exit
  #      misc {
  #      disable_hyprland_logo = true
  #      disable_splash_rendering = true
  #  #    disable_hyprland_qtutils_check = true
  #      }
  #'';
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        #command = "${pkgs.lib.getExe pkgs.hyprland} -c /etc/greetd/hyprland.conf";
        command = "${pkgs.lib.getExe pkgs.hyprland}";
        user = config.users.users.xadet.name;
      };
    };
  };
}

{ config, pkgs, inputs, lib, ... }:

let
  suitable_disk = builtins.head (builtins.filter (d: d ? "bus_type" && ! builtins.any (s: s == "usb") d.class_list) config.facter.report.hardware.disk);
  device = suitable_disk.unix_device_name;
in
{
  imports =
    [
      (import ./common/luks-interactive-login.nix { inherit device; })
    ];
  facter.reportPath = ./facter-cnc.json;


  xadetComputer = {
    type = "laptop";
    purposes = [ "cnc" ];
  };

  sops.secrets.jjdtt-password = {
    format = "binary";
    sopsFile = ../secrets/jjdtt-password-hash.txt;
    neededForUsers = true;
  };

  sops.secrets.password = {
    format = "binary";
    sopsFile = ../modules/purposes/perso/secrets/perso-password-hash.txt;
    neededForUsers = true;
  };

  users = {
    users = {
      jjdtt = {
        isNormalUser = true;
        createHome = true;
        hashedPasswordFile = config.sops.secrets.jjdtt-password.path;
      };
    };
  };

  programs.hyprland.enable = lib.mkForce false;
  services = {
    greetd.enable = lib.mkForce false;
    xserver = {
      enable = lib.mkForce true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  security.pam = {
    services.login.u2fAuth = lib.mkForce false;
    u2f.enable = lib.mkForce false;
  };

  home-manager = {
    users.jjdtt = {
      home.stateVersion = config.system.stateVersion;
      xdg.desktopEntries = {
        candle = {
          name = "candle";
          exec = "${lib.getExe pkgs.candle}";
          terminal = false;
          categories = [ "Application" ];
        };
      };
    };
  };

  i18n.defaultLocale = lib.mkForce "fr_FR.UTF-8";

  system.stateVersion = "24.11";
}

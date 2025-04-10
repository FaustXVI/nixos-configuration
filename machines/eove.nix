{ config, pkgs, inputs, ... }:

let
  laptop = "eDP-1";
  LG = "DP-1";
  Samsung = "DP-2";
  suitable_disk = builtins.head (builtins.filter (d: d ? "bus_type" && ! builtins.any (s: s == "usb") d.class_list) config.facter.report.hardware.disk);
  device = suitable_disk.unix_device_name;
in
{
  imports =
    [
      (import ./common/luks-interactive-login.nix { inherit device; })
    ];
  facter.reportPath = ./facter-eove.json;


  xadetComputer = {
    type = "laptop";
    purposes = [ "work" "home-office" "gaming" "3dPrinting" ];
  };

  system.stateVersion = "24.11";
}

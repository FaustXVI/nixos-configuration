{ config, pkgs, inputs, ... }:

let
  nixos-hardware = inputs.nixos-hardware;
  suitable_disk = builtins.head (builtins.filter (d: d ? "bus_type" && ! builtins.any (s: s == "usb") d.class_list) config.facter.report.hardware.disk);
  device = suitable_disk.unix_device_name;
in
{
  imports =
    [
      (import ./luks-interactive-login.nix { inherit device; })
    ];
  facter.reportPath = ./facter-eove.json;


  xadetComputer = {
    type = "laptop";
    purposes = [ "work" "home-office" "gaming" ];
  };

  services = {
    xserver = {
      dpi = 96;
    };
  };
  system.stateVersion = "24.11";
}

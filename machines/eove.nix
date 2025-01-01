{ config, pkgs, inputs, ... }:

let
  nixos-hardware = inputs.nixos-hardware;
in
{
  imports =
    [
      #nixos-hardware.nixosModules.framework-12th-gen-intel
#      ./eove-hardware.nix
      ../modules
      ./luks-interactive-login.nix
    ];
  facter.reportPath = ./facter-eove.json;


  xadetComputer = {
    type = "laptop";
    purposes = [ "work" "home-office" "gaming" ];
  };

  hardware.enableAllFirmware = true;
  services = {
    xserver = {
      dpi = 96;
    };
    fwupd.enable = true;
  };
  system.stateVersion = "21.05";
}

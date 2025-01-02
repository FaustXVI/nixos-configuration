{ config, pkgs, inputs, ... }:

let
  nixos-hardware = inputs.nixos-hardware;
in
{
  imports =
    [
      ./luks-interactive-login.nix
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

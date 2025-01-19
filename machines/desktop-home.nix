{ config, pkgs, inputs, ... }:

let
  LG = "HDMI-1";
  Samsung = "DP-2";
  device = "/dev/nvme1n1";
in
{
  imports =
    [
      (import ./luks-interactive-login.nix { inherit device; })
    ];
  xadetComputer = {
    type = "desktop";
    purposes = [ "perso" "gaming" "youtube" "photo" "home-office" ];
  };
  #hardware.nvidia.open = false;

  system.stateVersion = "24.11";
  time.hardwareClockInLocalTime = true;


}

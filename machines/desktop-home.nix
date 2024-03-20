{ config, pkgs, inputs, ... }:

let
  nixos-hardware = inputs.nixos-hardware;
in
{
  imports =
    [
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-cpu-amd-pstate
      nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
      nixos-hardware.nixosModules.common-pc
      nixos-hardware.nixosModules.common-pc-ssd
      ./desktop-home-hardware.nix
      ../modules
    ];
  xadetComputer = {
    type = "desktop";
    purposes = [ "home" "gaming" "youtube" "photo" "home-office" ];
  };

  services = {
    xserver = {
      dpi = 96;
      displayManager = {
        sessionCommands = ''
          xrandr --output DP-3 --mode 1920x1080 --output HDMI-0 --mode 2560x1080 --left-of DP-3 --primary &
        '';
      };
    };
  };

  system.stateVersion = "21.05";
  time.hardwareClockInLocalTime = true;
}

{ config, pkgs, ... }:

let
  hard = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware.git";
    rev = "b7ac0a56029e4f9e6743b9993037a5aaafd57103";
  };
in
{
  imports =
    [
      "${hard}/common/cpu/amd"
      "${hard}/common/cpu/amd/pstate.nix"
      "${hard}/common/gpu/nvidia"
      "${hard}/common/pc"
      "${hard}/common/pc/ssd"
      ../hardware-configuration.nix
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

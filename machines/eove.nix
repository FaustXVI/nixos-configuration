{ config, pkgs, ... }:

{
  imports =
    [
      "${builtins.fetchGit { 
        url = "https://github.com/NixOS/nixos-hardware.git";
        rev = "b7ac0a56029e4f9e6743b9993037a5aaafd57103";
      }}/framework/12th-gen-intel"
      ../hardware-configuration.nix
      ../modules
    ];


  xadetComputer = {
    type = "laptop";
    purposes = [ "work" "home-office" ];
    #    yubikeyAutolock = false;
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

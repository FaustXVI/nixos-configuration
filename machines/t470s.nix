{ config, pkgs, ... }:

{
  imports =
    [
      "${builtins.fetchGit {
        url = "https://github.com/NixOS/nixos-hardware.git";
        rev = "b7ac0a56029e4f9e6743b9993037a5aaafd57103";
      }}/lenovo/thinkpad/t470s"
      ../hardware-configuration.nix
      ../modules
    ];

  xadetComputer = {
    type = "laptop";
    purposes = [ "perso" ];
  };
  services = {
    xserver = {
      dpi = 150;
    };
  };
  system.stateVersion = "21.05";
}

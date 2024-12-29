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
      "${hard}/common/pc/laptop"
      ../hardware-configuration.nix
      ../modules
    ];

  xadetComputer = {
    type = "desktop";
    purposes = [ ];
  };

  system.stateVersion = "22.11";
}

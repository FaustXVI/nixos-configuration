{ config, pkgs, ... }:

{
  imports =
    [
      ./gaming.nix  
      ./home-printer.nix  
      ./nas.nix  
      ./obs.nix
    ];
  }

{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      apulse
      pavucontrol
    ];
  };
  programs = {
    noisetorch = {
      enable = true;
    };
  };
  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
  };
}

{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      apulse
      pavucontrol
    ];
  };
  hardware = {
    pulseaudio = {
      enable = false;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
  };
}

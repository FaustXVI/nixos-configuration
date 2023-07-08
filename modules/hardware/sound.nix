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
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
  };
}

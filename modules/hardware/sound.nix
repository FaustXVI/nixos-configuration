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
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
}

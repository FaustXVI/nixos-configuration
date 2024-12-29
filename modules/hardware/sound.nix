{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      apulse
      pavucontrol
    ];
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

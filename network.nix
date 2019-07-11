{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  networking.extraHosts = "127.0.0.1 nixos";

  services.openssh = {
    enable = true;
    gatewayPorts = "yes";
    extraConfig = ''
StreamLocalBindUnlink yes
      '';
  };
}

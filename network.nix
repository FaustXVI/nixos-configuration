{ config, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    enableStrongSwan = true;
  };
  networking.firewall.allowedTCPPorts = [];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    #strongswanNM
  ];

  networking.extraHosts = "127.0.0.1 nixos";

  services={
    #strongswan-swanctl = {
    #  enable = true;
    #};
    openssh = {
      enable = true;
      gatewayPorts = "yes";
      extraConfig = ''
        StreamLocalBindUnlink yes
      '';
    };
  };
}

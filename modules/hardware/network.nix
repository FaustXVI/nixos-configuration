{ config, pkgs, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
    };
    firewall.allowedTCPPorts = [ ];
    extraHosts = "127.0.0.1 nixos";
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];


  # See: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;

  services = {
    openssh = {
      enable = true;
      settings = {
        GatewayPorts = "yes";
      };
      extraConfig = ''
        StreamLocalBindUnlink yes
      '';
    };
  };
}

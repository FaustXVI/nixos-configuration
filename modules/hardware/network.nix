{ config, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
  };
  networking.firewall.allowedTCPPorts = [ ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  networking.extraHosts = "127.0.0.1 nixos";

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

{ config, pkgs, lib, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
    };
    firewall.allowedTCPPorts = [ 4040 ];
    extraHosts = "127.0.0.1 nixos";
  };

  # See: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

  hardware.enableRedistributableFirmware = true;

  services = {
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        GatewayPorts = "yes";
        StreamLocalBindUnlink = "yes";
      };
    };
  };
}

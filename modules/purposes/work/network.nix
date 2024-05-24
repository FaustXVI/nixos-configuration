{ mylib, pkgs, ... }:
{
  config = mylib.mkIfComputerHasPurpose "work" {
    environment = {
      systemPackages = with pkgs; [
        wireshark
      ];
    };
    programs = {
      wireshark = {
        enable = true;
      };
    };
    networking = {
      firewall = {
        allowedTCPPorts = [ 8000 8042 ];
        allowedUDPPorts = [ 8000 8042 ];
      };
      extraHosts = ''
        127.0.0.1 connect.local
        127.0.0.1 vestalis.local
      '';
    };
  };
}

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
  };
}

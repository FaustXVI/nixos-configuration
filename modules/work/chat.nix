{ mylib, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "work" {
    environment = {
      systemPackages = with pkgs; [
        slack
      ];
    };
  };

}

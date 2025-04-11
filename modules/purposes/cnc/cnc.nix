{ mylib, config, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "cnc" {
    environment = {
      systemPackages = with pkgs; [
        candle
      ];
    };
  };

}

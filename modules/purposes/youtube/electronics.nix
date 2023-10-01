{ mylib, config, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "youtube" {
    environment = {
      systemPackages = with pkgs; [
        fritzing
      ];
    };
  };

}

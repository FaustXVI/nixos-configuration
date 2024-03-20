{ mylib, pkgs, ... }:

{
  config = mylib.mkIfComputerIs "laptop" {
    services.blueman.enable = true;
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Enable = "Source,Sink,Media,Socket";
          };
        };
      };
    };
  };
}

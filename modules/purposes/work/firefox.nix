{ mylib, pkgs, config, lib, ... }:
let
  perso = config.home-manager.users.xadet.programs.firefox.profiles."perso";
in {
  config = mylib.mkIfComputerHasPurpose "work" {
    home-manager.users.xadet = { ... }: {
      programs.firefox.profiles = {
        "perso".isDefault = false;
        "eove" = {
          id = 1;
          isDefault = true;
          inherit (perso) settings search;
        };
        "fake" = {
          id = 3;
          isDefault = false;
          inherit (perso) settings search;
        };
      };
    };
  };
}

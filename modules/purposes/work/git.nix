{ mylib, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "work" {
    home-manager.users.xadet = {
      programs.git = {
            userName = "Xavier Detant";
      };
    };
  };
}

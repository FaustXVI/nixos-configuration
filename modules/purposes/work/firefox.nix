{ mylib, pkgs, ...}:
{
  config = mylib.mkIfComputerHasPurpose "work"{
    home-manager.users.xadet = {...}:{
      programs.firefox.profiles = {
        "perso".isDefault = false;
        "eove" = {
          id = 1;
          isDefault = true;
          settings = {
            "signon.rememberSignons" = false;
          };
        };
      };
    };
  };
}

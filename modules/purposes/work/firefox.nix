{ mylib, pkgs, ...}:
{
  config = mylib.mkIfComputerHasPurpose "work"{
    home-manager.users.xadet = {...}:{
      programs.firefox.profiles = rec {
        "perso".isDefault = false;
        "eove" = {
          id = 1;
          isDefault = true;
          settings = {
            "signon.rememberSignons" = false;
            "browser.startup.page" = 3;
          };
          search = "perso".search;
        };
      };
    };
  };
}

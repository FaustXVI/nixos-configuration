{ mylib, pkgs, config, ...}:
{
  config = mylib.mkIfComputerHasPurpose "work"{
    home-manager.users.xadet = {...}: rec {
      programs.firefox.profiles = {
        "perso".isDefault = false;
        "eove" = {
          id = 1;
          isDefault = true;
          settings = {
            "signon.rememberSignons" = false;
            "browser.startup.page" = 3;
          };
          search = config.home-manager.users.xadet.programs.firefox.profiles."perso".search;
        };
      };
    };
  };
}

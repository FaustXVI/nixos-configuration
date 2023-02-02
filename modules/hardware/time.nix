{ config, pkgs, ... }:

{

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    useXkbConfig = true;
  };

  time.timeZone = "Europe/Paris";

}

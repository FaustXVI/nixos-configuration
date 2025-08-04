{ config, pkgs, ... }:

{

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [
      "en_GB.UTF-8/UTF-8"
    ];
  };


  time.timeZone = "Europe/Paris";

}

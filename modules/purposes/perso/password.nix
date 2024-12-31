{ mylib, config, ... }:

{
  config = mylib.mkIfComputerHasPurpose "perso" {
    sops.secrets.password = {
      format = "binary";
      sopsFile = ./secrets/perso-password-hash.txt;
      neededForUsers = true;
    };
  };
}

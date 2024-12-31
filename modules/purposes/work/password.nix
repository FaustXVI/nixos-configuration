{ mylib, config, ... }:

{
  config = mylib.mkIfComputerHasPurpose "work" {
    sops.secrets.password = {
      format = "binary";
      sopsFile = ./secrets/work-password-hash.txt;
      neededForUsers = true;
    };
  };
}

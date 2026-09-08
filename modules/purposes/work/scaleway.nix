{ mylib, config, ... }:

{
  config = mylib.mkIfComputerHasPurpose "work" {
    sops.secrets."scaleway.token" = {
      format = "binary";
      sopsFile = ./secrets/scaleway.token;
      owner = config.users.users.xadet.name;
    };
  };
}

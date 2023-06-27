{ mylib, config, ... }:
let
  home = config.users.users.xadet.home;
in {
  config = mylib.mkIfComputerHasPurpose "work" {
    sops.secrets.githubToken = {
      format = "binary";
      sopsFile = ./secrets/githubToken;
      path = "${home}/.config/eove/githubToken";
      owner = config.users.users.xadet.name;
    };
  };
}

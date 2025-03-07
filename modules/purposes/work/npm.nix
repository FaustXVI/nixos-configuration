{ mylib, pkgs, config, ... }:

let
  home = config.users.users.xadet.home;
in
{
  config = mylib.mkIfComputerHasPurpose "work" {
    sops.templates.".npmrc" = {
      content = ''//npm.pkg.github.com/:_authToken=${config.sops.placeholder.githubToken}'';
      path = "${home}/.npmrc";
      owner = config.users.users.xadet.name;
    };
  };
}

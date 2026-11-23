{ mylib, pkgs, config, ... }:

let
  home = config.users.users.xadet.home;
in
{
  config = mylib.mkIfComputerHasPurpose "work" {
    environment = {
      systemPackages = with pkgs; [
        git-subrepo
      ];
    };

    sops.templates."githubToken.txt" = {
      content = ''${config.sops.placeholder."github/auth_and_packages"}'';
      path = "${home}/.githubToken";
      owner = config.users.users.xadet.name;
    };
    home-manager.users.xadet = {
      programs.git = {
        settings.user.name = "Xavier Detant";
      };
    };
  };
}

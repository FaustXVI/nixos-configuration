{ mylib, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "work" {
    environment = {
      systemPackages = with pkgs; [
        git-subrepo
      ];
    };

    home-manager.users.xadet = {
      programs.git = {
        userName = "Xavier Detant";
      };
    };
  };
}

{ config, pkgs, ... }:

{
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
      };
    };
    docker = {
      enable = true;
    };
  };

  users.extraGroups.vboxusers.members = [ "xadet" ];
}

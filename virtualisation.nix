{ config, pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
    };
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
  users.extraGroups.libvirtd.members = [ "xadet" ];
}

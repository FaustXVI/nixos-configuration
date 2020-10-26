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
  environment = {
    systemPackages = with pkgs; [
      virtualbox
    ];
  };

  users.extraGroups.vboxusers.members = [ "xadet" ];
}

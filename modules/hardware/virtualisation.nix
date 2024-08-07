{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      virt-manager
    ];
  };
  virtualisation = {
    docker = {
      enable = true;
    };
    libvirtd = {
      enable = true;
    };
  };

}

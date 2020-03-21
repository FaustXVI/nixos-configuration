{ config, lib, pkgs, ... }:

let
  password = import ./nas-password.nix;
in
{

  fileSystems."/home/xadet/nas" = {
    device = "//192.168.1.99/homes/xadet";
    fsType = "cifs";
    options = [
      "uid=1000"
      "gid=100"
      "user=xadet"
      "password=${password}"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };

}

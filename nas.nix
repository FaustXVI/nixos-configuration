{ config, lib, pkgs, ... }:

let
  password = import ./nas-password.nix;
  nasFolder = nasPath: {
    device = "//192.168.1.99"+nasPath;
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
in
{

  fileSystems."/home/xadet/nas" = nasFolder "/homes/xadet";
  fileSystems."/home/xadet/nasSharedPictures" = nasFolder "/Pics";
  fileSystems."/home/xadet/nasSharedWithMerve" = nasFolder "/PartageMeXa";
  fileSystems."/home/xadet/nasSharedWithDetant" = nasFolder "/PartageDetant";
}

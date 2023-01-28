{ config, lib, pkgs, ... }:

let
  nasFolder = nasPath: {
    device = "//192.168.1.99"+nasPath;
    fsType = "cifs";
    options = [
      "uid=${toString config.users.users.xadet.uid}"
      "credentials=${config.sops.secrets.nas.path}"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };
  mylib = import ../utils.nix { inherit lib config; };
in {
  config = mylib.mkIfComputerHasPurpose "home" {
    sops.secrets.nas = {
      format = "binary";
      sopsFile = ./secrets/nas-credentials.txt;
    };

    fileSystems."/home/xadet/nas" = nasFolder "/homes/xadet";
    fileSystems."/home/xadet/nas/SharedPictures" = nasFolder "/Pics";
    fileSystems."/home/xadet/nas/SharedWithMerve" = nasFolder "/PartageMeXa";
    fileSystems."/home/xadet/nas/SharedWithDetant" = nasFolder "/PartageDetant";
  };
}

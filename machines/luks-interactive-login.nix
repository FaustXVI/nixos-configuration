{ lib, config, ... }:
let
  suitable_disk = builtins.head (builtins.filter (d: d ? "bus_type" && ! builtins.any (s: s == "usb" ) d.class_list) config.facter.report.hardware.disk);
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = lib.mkDefault suitable_disk.unix_device_name;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            encryptedSwap = {
              size = "6G";
              content = {
                type = "swap";
                randomEncryption = true;
                resumeDevice = true;
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings.allowDiscards = true;
                askPassword = true;
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
{ config, lib, pkgs, ... }:

{
#  boot.initrd.kernelModules = [ "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" "uas" "usbcore" "usb_storage" ];
#  boot.initrd.luks = {
#
#    reusePassphrases = false;
#
#    # Support for Yubikey PBA
#    yubikeySupport = true;
#
#    devices."nixos-cyphered".yubikey = {
#      slot = 2;
#      twoFactor = true; # Set to false for 1FA
#      gracePeriod = 30; # Time in seconds to wait for Yubikey to be inserted
#      keyLength = 64; # Set to $KEY_LENGTH/8
#      saltLength = 16; # Set to $SALT_LENGTH
#
#      storage = {
#        device = "/dev/disk/by-label/SYSTEM"; # Be sure to update this to the correct volume
#      };
#    };
#  };
}

{ config, lib, pkgs, ... }:

{
  boot.initrd.kernelModules = ["vfat" "nls_cp437" "nls_iso8859-1" "usbhid" "uas" "usbcore" "usb_storage"];
  boot.initrd.preFailCommands = ''
            salt="$(cat /crypt-storage/crypt-storage/default | sed -n 1p | tr -d '\n')"
        iterations="$(cat /crypt-storage/crypt-storage/default | sed -n 2p | tr -d '\n')"
        challenge="$(echo -n $salt | openssl-wrap dgst -binary -sha512 | rbtohex)"
        response="$(ykchalresp -2 -x $challenge 2>/dev/null)"
                    echo -n "Enter two-factor passphrase: "
            read -r k_user
            echo
            if [ ! -z "$k_user" ]; then
                k_luks="$(echo -n $k_user | pbkdf2-sha512 64 $iterations $response | rbtohex)"
            else
                k_luks="empty"
            fi
    echo "salt : $salt\nit : $iterations\nchal: $challenge\nres: $response"
    echo "k: $k_luks"
     echo -n "$k_luks" | hextorb | cryptsetup luksOpen /dev/nvme1n1p1 nixos-cyphered --key-file=-
     echo "$?"
    '';
  boot.initrd.luks = {
    # Update if necessary
    cryptoModules = ["aes" "xts" "sha512"];

    # Support for Yubikey PBA
    yubikeySupport = true;

    devices."nixos-cyphered".yubikey = {
        slot = 2;
        twoFactor = true; # Set to false for 1FA
        gracePeriod = 30; # Time in seconds to wait for Yubikey to be inserted
        keyLength = 64; # Set to $KEY_LENGTH/8
        saltLength = 16; # Set to $SALT_LENGTH

        storage = {
          device = "/dev/disk/by-label/SYSTEM"; # Be sure to update this to the correct volume
        };
      };
  };
}

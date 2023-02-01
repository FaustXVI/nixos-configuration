{mylib, ... }@args:

{
  imports = mylib.importsWith args
    [
    ./keyboard.nix
    ./network.nix
    ./gui.nix
    ./virtualisation.nix
    ./yubikey.nix
    ./luks.nix
    ./time.nix
    ./sound.nix
    ./ntfs.nix
    ./power-button.nix
    ./printing.nix
    ./bootloader.nix
    ./acpi.nix
    ./light.nix
    ./bluetooth.nix
  ];
}

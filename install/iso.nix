# This module defines a small NixOS installation CD.  It does not
# contain any graphical stuff.
{ config, pkgs, ... }:
let
  install-script = pkgs.callPackage ./scripts {  };
  tar = builtins.fetchTarball {
               url = https://github.com/FaustXVI/nixos-yubikey-luks/archive/master.tar.gz;
               # Hash obtained using `nix-prefetch-url --unpack <url>`
               sha256 = "04kya074mk34ch1vpa4rhkn9bxmvid198p45ryd4d0xfanjhq9w8";
             };
  my = import tar { nixpkgs = pkgs; };
in {
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
  imports = [
    <nixos/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixos/nixos/modules/installer/cd-dvd/channel.nix>
  ];
  console.keyMap = "fr";
  environment.systemPackages= with pkgs; [
      git
      gnupg
      openssl
      install-script
    ] ++ my.buildInputs;
}
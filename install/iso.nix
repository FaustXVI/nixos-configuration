# This module defines a small NixOS installation CD.  It does not
# contain any graphical stuff.
{ self, system, nixpkgs, pkgs, ... }:
(nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    {
      isoImage.squashfsCompression = "gzip -Xcompression-level 1";
      console.keyMap = "fr";
      environment.systemPackages = [
        self.packages."${system}".install-script
      ];
      users.users = {
        root = {
          password = "nixos";
          initialHashedPassword = nixpkgs.lib.mkForce null;
        };
        nixos = {
          password = "nixos";
          initialHashedPassword = nixpkgs.lib.mkForce null;
        };
      };
    }
  ];
}).config.system.build.isoImage

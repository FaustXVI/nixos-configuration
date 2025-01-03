{ self, system, nixpkgs, pkgs, target, ... }:
(nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    #"${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    ({config, ...}:{
      isoImage = {
        squashfsCompression = "gzip -Xcompression-level 1";
        isoBaseName = "nixos-xadet-${target}-installer-${config.system.nixos.release}";
      };
      console.keyMap = "fr";
      nix = {
        settings = {
          experimental-features = [ "nix-command" "flakes" ];
        };
      };
      environment.systemPackages = [
        pkgs.nixos-facter
        self.packages."${system}"."install-script-${target}"
      ];
      services.xserver.xkb = {
        layout = "fr";
      };
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
    })
  ];
}).config.system.build.isoImage

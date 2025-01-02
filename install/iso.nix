{ self, system, nixpkgs, pkgs, target, ... }:
let
  to-install = self.nixosConfigurations.${target};
  dependencies = [
    to-install.config.system.build.toplevel
    to-install.config.system.build.diskoScript
    to-install.config.system.build.diskoScript.drvPath
    to-install.pkgs.stdenv.drvPath

    # https://github.com/NixOS/nixpkgs/blob/f2fd33a198a58c4f3d53213f01432e4d88474956/nixos/modules/system/activation/top-level.nix#L342
    to-install.pkgs.perlPackages.ConfigIniFiles
    to-install.pkgs.perlPackages.FileSlurp

    (to-install.pkgs.closureInfo { rootPaths = [ ]; }).drvPath
  ] ++ builtins.map (i: i.outPath) (builtins.attrValues self.inputs);

  closureInfo = pkgs.closureInfo { rootPaths = dependencies; };
in
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
      environment.etc."install-closure".source = "${closureInfo}/store-paths";
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

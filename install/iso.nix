{ self, system, nixpkgs, pkgs, targets, ... }:
let
  scripts = builtins.map (target: self.packages."${system}"."install-script-${target}") targets;
in
(nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    #"${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    ({ config, ... }: {
      isoImage = {
        squashfsCompression = "gzip -Xcompression-level 1";
        isoBaseName = "nixos-xadet-installer-${config.system.nixos.release}";
      };
      console = {
        earlySetup = true;
        useXkbConfig = true;
      };
      nix = {
        settings = {
          experimental-features = [ "nix-command" "flakes" ];
        };
      };
      networking = {
        networkmanager.enable = true;
        wireless.enable = false;
      };
      environment.systemPackages = [
        pkgs.networkmanager
        pkgs.nixos-facter
      ] ++ scripts;
      services = {
        openssh = {
          enable = true;
          openFirewall = true;
        };
        xserver.xkb = {
          layout = "fr,fr";
          variant = "oss,bepo";
          options = "grp:menu_toggle";
        };
      };
      users.users = {
        root = {
          password = "nixos";
          initialHashedPassword = nixpkgs.lib.mkForce null;
          openssh = {
            authorizedKeys = {
              keyFiles = [ ../modules/system/ssh-keys/xadet-ed.pub ];
            };
          };
        };
        nixos = {
          password = "nixos";
          initialHashedPassword = nixpkgs.lib.mkForce null;
        };
      };
    })
  ];
}).config.system.build.isoImage

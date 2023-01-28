{ config, pkgs, ... }:

let
  sops-nix-version = "master";
  sops-nix-url = "https://github.com/Mic92/sops-nix/archive/${sops-nix-version}.tar.gz";
in {
  imports = [ "${builtins.fetchTarball sops-nix-url}/modules/sops" ];
  sops.age.sshKeyPaths = [];
  sops.gnupg.sshKeyPaths = [];
  sops.age.keyFile = "/etc/nixos/keys/ageKey.txt";
}

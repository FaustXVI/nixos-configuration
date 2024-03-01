{ config, pkgs, ... }:

{
  sops.age.sshKeyPaths = [ ];
  sops.gnupg.sshKeyPaths = [ ];
  sops.age.keyFile = "/etc/nixos/keys/ageKey.txt";
}

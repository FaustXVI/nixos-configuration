{ config, pkgs, ... }:

{
  sops.age.sshKeyPaths = [ ];
  sops.gnupg.sshKeyPaths = [ ];
  sops.age.keyFile = "/root/ageKey.txt";
}

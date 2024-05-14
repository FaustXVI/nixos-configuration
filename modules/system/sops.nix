{ config, pkgs, ... }:

let
  sops-nix-version = "632c3161a6cc24142c8e3f5529f5d81042571165";
  sops-nix-url = "https://github.com/Mic92/sops-nix/archive/${sops-nix-version}.tar.gz";
in
{
  imports = [ "${builtins.fetchTarball sops-nix-url}/modules/sops" ];
  sops.age.sshKeyPaths = [ ];
  sops.gnupg.sshKeyPaths = [ ];
  sops.age.keyFile = "/etc/nixos/keys/ageKey.txt";
}

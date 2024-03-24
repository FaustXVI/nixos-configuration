{ config, pkgs, ... }:

{
  system = {
    autoUpgrade = {
      enable = true;
      dates = "13:00";
      persistent = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  sops.secrets.extra-nix-conf = {
    format = "binary";
    sopsFile = ./secrets/extra-nix.conf;
  };
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    extraOptions = ''
      min-free = ${toString (10 * 1024 * 1024 * 1024)}
      !include ${config.sops.secrets.extra-nix-conf.path}
    '';
    gc = {
      dates = "13:10";
      automatic = true;
      options = "--delete-older-than 90d";
    };
    optimise = {
      dates = [ "13:20" ];
      automatic = true;
    };
  };
}

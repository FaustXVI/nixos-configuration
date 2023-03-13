{ config, pkgs, ... }:

{
  system = {
    autoUpgrade = {
      enable = true;
      dates = "13:00";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    extraOptions = ''
      min-free = ${toString (10 * 1024 * 1024 * 1024)}
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

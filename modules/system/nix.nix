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
    gc = {
      dates = "weekly";
      automatic = true;
    };
    optimise = {
      dates = [ "weekly" ];
      automatic = true;
    };
  };
}

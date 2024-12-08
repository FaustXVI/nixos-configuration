{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      terminator
    ];
  };
  programs = {
    bash = {
      completion = {
        enable = true;
      };
    };
    fish = {
      enable = true;
    };
  };
}

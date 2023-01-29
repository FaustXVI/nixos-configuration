{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      terminator
    ];
  };
  programs = {
    bash = {
      enableCompletion = true;
    };
    fish = {
      enable = true;
    };
  };
}

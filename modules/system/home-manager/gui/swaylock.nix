{ pkgs, lib, config, ... }:
{
  programs.swaylock = {
    enable = true;
    settings = {
      image = "${./background-image}";
    };
  };
}

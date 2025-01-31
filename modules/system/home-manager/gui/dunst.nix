{ pkgs, lib, config, ... }:
{
  services.dunst = {
    enable = true;
  };
  xdg.configFile = {
    "dunst/dunstrc.d/99-xadet.conf".text = ''
[global]
corner_radius=50
    '';
    };
}

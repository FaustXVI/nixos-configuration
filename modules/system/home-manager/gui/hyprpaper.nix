{ pkgs, lib, config, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {

      preload = [ "${./background-image}" ];
      wallpaper = [ ",${./background-image}" ];
    };
  };
}

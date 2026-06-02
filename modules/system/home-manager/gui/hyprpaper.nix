{ pkgs, lib, config, ... }:
    let
    conf = pkgs.writeText "hyprpaper.conf" ''
       splash = false
       wallpaper {
         monitor =
         path = ${./background-image}
       }
    '';
in {
  services.hyprpaper = {
    enable = true;
    settings = {
       source = "${conf}";
    };
  };
}

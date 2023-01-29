{...}:
let
  pkgs = import <nixos-unstable> {};
in {
  home.packages = with pkgs; [
    firefox
    google-chrome
    spotify
    vlc
    feh
    simplescreenrecorder
    gimp
    rawtherapee
    shotwell
    dia
  ];
}

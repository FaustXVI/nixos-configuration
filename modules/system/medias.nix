{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      unstable.google-chrome
      spotify
      playerctl
      vlc
      feh
      dia
      foliate
    ];
  };
}

{ pkgs, unstable, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      unstable.google-chrome
      unstable.firefox-bin
      spotify
      vlc
      feh
      dia
      foliate
    ];
  };
}

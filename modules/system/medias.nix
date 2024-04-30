{ pkgs, unstable, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      unstable.google-chrome
      unstable.firefox
      spotify
      vlc
      feh
      dia
      foliate
    ];
  };
}

{pkgs,unstable,...}:
{
  home.packages = with pkgs; [
    unstable.firefox
    unstable.google-chrome
    spotify
    vlc
    feh
    dia
    foliate
  ];
}

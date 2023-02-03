{pkgs,unstable,...}:
{
  environment = {
    systemPackages = with pkgs; [
      unstable.firefox
      unstable.google-chrome
      spotify
      vlc
      feh
      dia
      foliate
    ];
  };
}

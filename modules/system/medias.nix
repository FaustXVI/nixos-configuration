{pkgs,unstable,...}:
{
  environment = {
    systemPackages = with pkgs; [
      unstable.google-chrome
      spotify
      vlc
      feh
      dia
      foliate
    ];
  };
}

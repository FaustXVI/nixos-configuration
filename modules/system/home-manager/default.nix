{ pkgs, ...}:
{
  imports = [
    ./dev
    ./shells
    ./gui
    ./editors
    ./crypto
    ./nix
    ./medias.nix
  ];
  home.stateVersion = "22.05";
  programs = {
    home-manager = {
      enable = true;
    };
  };
}

{ pkgs, mylib, ... }@args:
let
in
{
  programs = {
    starship = {
      enable = true;
    };
  };
  home.file.".config/starship.toml".source = ./starship.toml;
}

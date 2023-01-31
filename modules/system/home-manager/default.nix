{ lib, config, ...}@args:
let
  mylib = import ../../utils.nix args;
in {
  imports = mylib.importsWith args [
    ./dev
    ./shells
    ./gui
    ./editors
    ./crypto
    ./nix
    ./medias.nix
    ];
  config = {
    home.stateVersion = "22.05";
    programs = {
      home-manager = {
        enable = true;
      };
    };
  };
}

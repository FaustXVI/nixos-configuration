{mylib,...}@args:
let
  unstable = import <nixos-unstable> {};
in {
  imports = mylib.importsWith (args // {inherit unstable;}) [
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

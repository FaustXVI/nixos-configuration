{lib, config, ...}@args:
let
  unstable = import <nixos-unstable> {};
  mylib = import ../../../utils.nix args;
in { 
  imports = mylib.importsWith args [
    ./git.nix
  ];
  config = {
    home.packages = with unstable; [
      jetbrains.idea-ultimate
      docker-compose
    ];
  };
}

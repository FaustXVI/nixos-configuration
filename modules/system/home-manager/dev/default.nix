{ ...}:
let
  pkgs = import <nixos-unstable> {};
in {
  imports = [
    ./git.nix
  ];
  home.packages = with pkgs; [
    jetbrains.idea-ultimate
    docker-compose
  ];
}

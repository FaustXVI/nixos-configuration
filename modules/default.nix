{ lib, pkgs, config, ... }@args:
with lib;
let
  unstable = import <nixos-unstable> {};
  mylib = import ./utils.nix args;
in {
  imports = mylib.importAllFilteredWith (n: n != "utils.nix") (args // {inherit mylib unstable;}) ./.;
  config = {
    nixpkgs.config.packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };
  options = {
    xadetComputer = {
      type = mkOption {
        type = with types; enum mylib.computerTypes;
      };
      purposes = mkOption {
        type = with types; listOf (enum mylib.purposesTypes);
      };
      yubikeyAutolock = mkOption {
        type = with types; bool;
        default = true;
      };
    };
  };
}
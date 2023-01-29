{ lib, pkgs, config, ... }:
with lib;
let
  mylib = import ./utils.nix { inherit lib config; };
in {
  imports = [ 
    ./system
    ./hardware
    ./home
    ./work
  ];
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

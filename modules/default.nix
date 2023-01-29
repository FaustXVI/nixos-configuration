{ lib, pkgs, config, mylib, ... }:
with lib;
{
  imports = [ 
    ./system
    ./hardware
    ./home
  ];
  options = {
    xadetComputer = {
      type = mkOption {
        type = with types; enum mylib.computerTypes;
      };
      purposes = mkOption {
        type = with types; listOf (enum mylib.purposesTypes);
      };
    };
  };
}

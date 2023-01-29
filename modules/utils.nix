{ lib, config, ... }:
with lib;
let
  contains = e: c: lib.any (x: x == e) c;
in rec {
  computerTypes = [ "laptop" "desktop" ];
  purposesTypes = [ "home" "work" "gaming" "youtube" "photo" ];

  mkIfComputerIs = type: assert assertMsg (contains type computerTypes ) "${type} is not a computer type";
                         mkIf (config.xadetComputer.type == type);
  mkIfComputerHasPurpose = purpose: assert assertMsg (contains purpose purposesTypes ) "${purpose} is not a purposes type";
                         mkIf (contains purpose config.xadetComputer.purposes);
}

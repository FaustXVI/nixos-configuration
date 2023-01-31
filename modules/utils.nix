{ lib, config, ... }:
with lib;
let
  contains = e: c: lib.any (x: x == e) c;
in rec {
  computerTypes = [ "laptop" "desktop" ];
  purposesTypes = [ "home" "work" "gaming" "youtube" "photo" ];

  importsWith = args: paths: map (path: import path args) paths;

  computerIs = type: assert assertMsg (contains type computerTypes ) "${type} is not a computer type"; config.xadetComputer.type == type;

  computerHasPurpose = purpose: assert assertMsg (contains purpose purposesTypes ) "${purpose} is not a purposes type";contains purpose config.xadetComputer.purposes;

  mkIfComputerIs = type: mkIf (computerIs type);
  mkIfComputerHasPurpose = purpose: mkIf (computerHasPurpose purpose);
}

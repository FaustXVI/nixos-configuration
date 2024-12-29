{ lib, pkgs, config, ... }@args:
with lib;
let
  mylib = import ./utils.nix args;
in
{
  imports = mylib.importAllFilteredWith (n: n != "utils.nix") (args // { inherit mylib; }) ./.;
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

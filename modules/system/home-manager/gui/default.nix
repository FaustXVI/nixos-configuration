{...}@args:

let
  mylib = import ../../../utils.nix args;
in {
  imports = mylib.importsWith args [
    ./i3.nix
  ];
}

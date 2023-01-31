{ ...}@args:

let
  mylib = import ../../../utils.nix args;
in {
  imports = mylib.importsWith args [
    ./emacs.nix
    ./vim.nix
  ];
}

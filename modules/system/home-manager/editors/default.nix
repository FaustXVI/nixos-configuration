{mylib,...}@args:

{
  imports = mylib.importsWith args [
    ./emacs.nix
    ./vim.nix
  ];
}

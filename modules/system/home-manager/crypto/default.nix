{mylib,...}@args:

{
  imports = mylib.importsWith args [
    ./gpg.nix
  ];
}

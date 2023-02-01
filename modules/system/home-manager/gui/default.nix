{mylib,...}@args:

{
  imports = mylib.importsWith args [
    ./i3.nix
  ];
}

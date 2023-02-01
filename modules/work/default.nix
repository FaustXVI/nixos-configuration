{ mylib, ... }@args:

{
  imports = mylib.importsWith args
    [
      ./chat.nix  
    ];
  }

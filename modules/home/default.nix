{ mylib, ... }@args:

{
  imports = mylib.importsWith args
    [
      ./gaming.nix  
      ./home-printer.nix  
      ./nas.nix  
      ./obs.nix
    ];
  }

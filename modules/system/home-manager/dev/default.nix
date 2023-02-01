{mylib,unstable, ...}@args:
{ 
  imports = mylib.importsWith args [
    ./git.nix
  ];
  config = {
    home.packages = with unstable; [
      jetbrains.idea-ultimate
      docker-compose
    ];
  };
}

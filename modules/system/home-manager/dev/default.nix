{mylib,unstable, ...}@args:
{ 
  imports = mylib.importAllWith args (builtins.toString ./.);
  config = {
    home.packages = with unstable; [
      jetbrains.idea-ultimate
      docker-compose
    ];
  };
}

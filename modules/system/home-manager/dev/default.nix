{ mylib, unstable, ... }@args:
{
  imports = mylib.importAllWith args (builtins.toString ./.);
}

{ mylib, ... }@args:
{
  imports = mylib.importAllWith args (builtins.toString ./.);
}

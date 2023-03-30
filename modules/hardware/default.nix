{ mylib, ... }@args:

{
  imports = mylib.importAllWith args ./.;
}

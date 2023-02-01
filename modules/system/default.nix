{ mylib, ... }@args:

{
  imports = mylib.importsWith args
    [
    ./sops.nix
    ./users.nix
    ./nix.nix
    ./fonts.nix
    ./shells.nix
    ./crypto.nix
    ./anti-virus.nix
    ./programming.nix
    ./spelling.nix
    ./cli-tools.nix
    ./editor.nix
  ];
}

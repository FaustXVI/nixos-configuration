{ pkgs, ...}:
with pkgs; {
  home.file.".gnupg" = {
    recursive = true;
    source = ./gpg-config;
  };
}

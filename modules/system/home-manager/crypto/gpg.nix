{ pkgs, mylib, ... }:
with pkgs; {
  programs = {
    gpg = {
      enable = true;
      scdaemonSettings = {
        disable-ccid = true;
      };
      publicKeys = map (source: {inherit source; trust = "ultimate";} ) (mylib.filesInDir ./public-keys);
    };
  };
}

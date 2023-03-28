{ pkgs, ...}:
with pkgs; {
  programs = {
    gpg = {
      enable = true;
      publicKeys = [
        { source = ./xadet-public.key; }
      ];
    };
  };
}

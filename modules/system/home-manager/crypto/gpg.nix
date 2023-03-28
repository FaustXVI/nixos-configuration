{ pkgs, ...}:
with pkgs; {
  programs = {
    gpg = {
      enable = true;
      scdaemonSettings = {
        disable-ccid = true;
      };
      publicKeys = [
        { source = ./xadet-public.key; }
      ];
    };
  };
}

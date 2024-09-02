{ pkgs, ... }:
{
  programs = {
    fish = {
      enable = true;
      plugins = with pkgs; [
        {
          name = "bangbang";
          src = fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-bang-bang";
            rev = "816c66df34e1cb94a476fa6418d46206ef84e8d3";
            sha256 = "35xXBWCciXl4jJrFUUN5NhnHdzk6+gAxetPxXCv4pDc=";
          };
        }
      ];
    };
  };
}

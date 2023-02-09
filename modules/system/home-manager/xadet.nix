{mylib,...}@args:
{
  imports = mylib.importAllFilteredWith (n: n != "root.nix" && n != "xadet.nix") args ./.;
  config = {
    home = {
      stateVersion = "22.05";
      enableNixpkgsReleaseCheck = true;
    };
    programs = {
      home-manager = {
        enable = true;
      };
    };
  };
}

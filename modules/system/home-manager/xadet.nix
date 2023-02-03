{mylib,...}@args:
{
  imports = mylib.importAllFilteredWith (n: n != "root.nix" && n != "xadet.nix") args ./.;
  config = {
    home.stateVersion = "22.05";
    programs = {
      home-manager = {
        enable = true;
      };
    };
  };
}

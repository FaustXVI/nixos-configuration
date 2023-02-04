{mylib, config, ...}@args:
{
  imports = mylib.importAllFilteredWith (n: n != "root.nix" && n != "xadet.nix") args ./.;
  config = {
    home = {
      stateVersion = config.system.stateVersion;
      enableNixpkgsReleaseCheck = true;
    };
    programs = {
      home-manager = {
        enable = true;
      };
    };
  };
}

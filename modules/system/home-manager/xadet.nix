{ mylib, config, pkgs, ... }@args:
{
  imports = [
    pkgs.inputs.catppuccin.homeManagerModules.catppuccin
  ] ++ (mylib.importAllFilteredWith (n: n != "root.nix" && n != "xadet.nix") args ./.);
  config = {
    catppuccin = {
      cursors = {
        enable = true;
        accent = "dark";
      };
      accent = "teal";
      flavor = "mocha";
      enable = true;
    };
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

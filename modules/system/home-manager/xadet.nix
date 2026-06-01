{ mylib, config, pkgs, ... }@args:
{
  imports = [
    pkgs.inputs.catppuccin.homeModules.catppuccin
  ] ++ (mylib.importAllFilteredWith (n: n != "root.nix" && n != "xadet.nix") args ./.);
  config = {
    catppuccin = {
      cursors = {
        enable = true;
        accent = "rosewater";
      };
      accent = config.catppuccin.accent;
      flavor = config.catppuccin.flavor;
      enable = true;
      autoEnable = true;
    };
    gtk.enable = true;
    xdg.enable = true;
    home = {
      pointerCursor = {
        x11.enable = true;
        gtk.enable = true;
      };
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

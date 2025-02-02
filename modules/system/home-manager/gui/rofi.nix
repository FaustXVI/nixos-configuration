{ pkgs, lib, config, ... }:
{
  programs.rofi = {
    enable = true;
    font = lib.lists.head config.fonts.fontconfig.defaultFonts.monospace;
    terminal = "${lib.getExe pkgs.kitty}";
    extraConfig = {
      modi = "run,drun";
      icon-theme = "Oranchelo";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 󰕰  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
    };
    theme = 
      let
  # Use `mkLiteral` for string-like values that should show without
  # quotes, e.g.:
  # {
  #   foo = "abc"; => foo: "abc";
  #   bar = mkLiteral "abc"; => bar: abc;
  # };
  inherit (config.home-manager.users.xadet.lib.formats.rasi) mkLiteral;
in {
      "window, mainbox, inputbar, listview, entry, element, element selected, button, button selected, textbox" = {
        background-color= mkLiteral "transparent";
      };
      "*" = {
        accent = mkLiteral "#74c7ec";
        blue = mkLiteral "@accent";
      };
      window = {
        border-radius= mkLiteral "10px";
        border-color= mkLiteral "@accent";
      };
    };
  };

}

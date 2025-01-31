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
  };

}

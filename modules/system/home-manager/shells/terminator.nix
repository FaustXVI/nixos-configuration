{...}:
let
  font = "Fira Code Light 16";
  black = "#111111";
  white = "#eeeeee";
  cursor = "#999999";
in {
programs.terminator = {
  enable = true;
  config = {
    global_config = {
      always_split_with_profile = true;
      title_use_system_font = false;
      title_font = "${font}";
      putty_paste_style_source_clipboard = true;
    };
    profiles = {
      "default" = {
        foreground_color = "${white}";
        cursor_color = "${cursor}";
        font = "${font}";
        scrollback_infinite = true;
        use_system_font = false;
      };
      "projector" = {
        foreground_color = "${black}";
        background_color = "${white}";
        cursor_color = "${cursor}";
        font = "${font}";
        scrollback_infinite = true;
        use_system_font = false;
      };
    };
  };
};
}

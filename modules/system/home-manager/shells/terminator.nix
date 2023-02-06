{...}:
let
  font = "Fira Code Light 16";
  black = "#00000";
  white = "#ffffff";
  cursor = "#aaaaaa";
in {
  xdg.configFile."terminator/config".source = ./terminator.config ;
#  xdg.configFile."terminator/config".text = ''
#[global_config]
#  always_split_with_profile = True
#  title_use_system_font = False
#  title_font = ${font}
#  putty_paste_style_source_clipboard = True
#[keybindings]
#[profiles]
#  [[default]]
#    foreground_color = "${white}"
#    cursor_color = "${cursor}"
#    font = ${font}
#    scrollback_infinite = True
#    use_system_font = False
#  [[projector]]
#    foreground_color = "${black}"
#    background_color = "${white}"
#    cursor_color = "${cursor}"
#    font = ${font}
#    scrollback_infinite = True
#    use_system_font = False
#[layouts]
#  [[default]]
#    [[[child1]]]
#      parent = window0
#      type = Terminal
#    [[[window0]]]
#      parent = ""
#      type = Window
#[plugins]
#    '';
}

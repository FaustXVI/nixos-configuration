{ ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        font = wezterm.font 'Fira Code',
        font_size = 18,
        scrollback_lines = 20000,
        color_scheme = 'Darcula (base16)',
        keys = {
           {
             mods = 'ALT',
             key = 'w',
             action = wezterm.action.CloseCurrentTab { confirm = true },
           }, {
             mods = 'ALT',
             key = 't',
             action = wezterm.action.SpawnTab 'CurrentPaneDomain',
           }, { 
             mods = 'SHIFT|ALT', 
             key = 't', 
             action = wezterm.action.ShowTabNavigator 
           }, {
             key = 'e',
             mods = 'ALT',
             action = wezterm.action.PromptInputLine {
               description = 'Enter new name for tab',
               action = wezterm.action_callback(function(window, pane, line)
                 -- line will be `nil` if they hit escape without entering anything
                 -- An empty string if they just hit enter
                 -- Or the actual line of text they wrote
                 if line then
                   window:active_tab():set_title(line)
                 end
               end),
             },
           },
        }
      }
    '';
  };
}

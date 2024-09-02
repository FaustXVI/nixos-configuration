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
      }
    '';
  };
}

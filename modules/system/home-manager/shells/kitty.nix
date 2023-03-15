{...}:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Fira Code Retina Nerd Font Complete Mono";
      size = 18;
    };
    settings = {
      enable_audio_bell = false;
      scrollback_lines = 20000;
    };
    extraConfig = ''
      include themes.conf
    '';
  };
}

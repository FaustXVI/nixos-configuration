{ ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Fira Code";
      size = 18;
    };
    settings = {
      enable_audio_bell = false;
      scrollback_lines = 20000;
    };
    keybindings = {
      "super+n" = "launch --cwd=current --type=os-window";
    };
    extraConfig = ''
      include themes.conf
    '';
  };
}

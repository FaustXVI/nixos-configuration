{...}:
let
  font = "Fira Code Light 16";
  black = "#111111";
  white = "#eeeeee";
  cursor = "#999999";
in {
  programs.kitty = {
    enable = true;
    font = {
      name = "Fira Code";
      size = 18;
    };
    settings = {
      enable_audio_bell = false;
    };
  };
}

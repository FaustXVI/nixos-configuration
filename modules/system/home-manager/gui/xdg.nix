{ pkgs, ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = ["gimp.desktop" "feh.desktop"];
    };
  };
}

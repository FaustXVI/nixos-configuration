{ pkgs, lib, config, ... }:
{
  programs.wlogout = {
    enable = true;
  };
  catppuccin.wlogout.extraStyle = ''
    button {
    border-radius: 10px;
    }
    window {
    background: transparent;
    }
  '';
}

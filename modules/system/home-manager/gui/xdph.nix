{ pkgs, lib, config, ... }:
{
  home.file.".config/hypr/xdph.conf".text = ''
screencopy {
    allow_token_by_default = true
}
    '';
    }

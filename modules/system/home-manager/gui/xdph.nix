{ pkgs, lib, config, ... }:
{
  xdg.configFile."hypr/xdph.conf".text = ''
    screencopy {
        allow_token_by_default = true
    }
  '';
}

{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      terminator
    ];
    shellInit = ''
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';
  };
  programs = {
    bash = {
      enableCompletion = true;
    };
    fish = {
      enable = true;
    };
  };
}

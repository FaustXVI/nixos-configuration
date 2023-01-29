{pkgs,...}:
{
  # TODO :
  # checkout git@github.com:FaustXVI/omf-config in .config/omf
  # omf-install
  programs = {
    fish = {
      enable = true;
    };
  };
  home.packages = with pkgs; [
    oh-my-fish
  ];
  xdg.configFile."fish/functions/fish_user_key_bindings.fish".source = ./key_bindings.fish ;
}

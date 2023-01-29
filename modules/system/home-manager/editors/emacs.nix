{pkgs,...}:
{
  home = {
    packages = with pkgs; [
      emacs
    ];
    file.".emacs.d/init.el".source = ./init.el;
  };
}

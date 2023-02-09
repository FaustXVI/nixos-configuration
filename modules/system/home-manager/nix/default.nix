{ pkgs, ...}:
{
  xdg.configFile."nixpkgs/config.nix".source = ./config.nix ;
  programs = {
    nix-index = {
      enable = true;
    };
  };
  home.packages = with pkgs; [
    nix-index
    patchelf
    autoPatchelfHook
    nix-prefetch-git
    nix-prefetch-scripts
    any-nix-shell
  ];
}

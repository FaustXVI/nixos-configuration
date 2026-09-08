{ pkgs, ... }:
{
  programs = {
    fish = {
      enable = true;
      plugins = with pkgs; [
        {
          name = "bangbang";
          src = fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-bang-bang";
            rev = "ec991b80ba7d4dda7a962167b036efc5c2d79419";
            sha256 = "sha256-oPPCtFN2DPuM//c48SXb4TrFRjJtccg0YPXcAo0Lxq0=";
          };
        }
      ];
    };
  };
}
